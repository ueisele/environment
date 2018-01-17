import groovy.json.JsonSlurper
import org.sonatype.nexus.repository.config.Configuration
import org.sonatype.nexus.security.realm.RealmManager

parsed_args = new JsonSlurper().parseText(args)

realmManager = container.lookup(RealmManager.class.getName())
realmManager.enableRealm('DockerToken')

configuration = new Configuration(
        repositoryName: parsed_args.name,
        recipeName: 'docker-hosted',
        online: true,
        attributes: [
                docker: [
                        httpPort: parsed_args.http_port,
                        v1Enabled : true
                ],
                storage: [
                        writePolicy: 'ALLOW',
                        blobStoreName: parsed_args.blob_store,
                        strictContentTypeValidation: true
                ]
        ]
)

def existingRepository = repository.getRepositoryManager().get(parsed_args.name)

if (existingRepository != null) {
    existingRepository.stop()
    configuration.attributes['storage']['blobStoreName'] = existingRepository.configuration.attributes['storage']['blobStoreName']
    existingRepository.update(configuration)
    existingRepository.start()
} else {
    repository.getRepositoryManager().create(configuration)
}