#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
DIR_CONFIG_NEXUS3=$(pwd)
source ../../../ips.sh
source ./declare_scripts.sh
source ./create_blobstore.sh
source ./create_repo_docker_hosted.sh
popd > /dev/null

function init_nexus () {
    while ! curl --output /dev/null --silent --head --fail http://$(ip_of_service "nexus3" 1):8081; do sleep 1 && echo -n .; done;
    declare_scripts "${DIR_CONFIG_NEXUS3}/script"
    create_blobstore "docker-private"
    create_repo_docker_hosted "docker-private" 8082 "docker-private"
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    init_nexus "$@"
fi