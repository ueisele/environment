#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
source ../../../ips.sh
popd > /dev/null

function declare_script () {
    script_filepath=${1:?'Missing script filepath as first parameter!'}
    nexus_ip=$(ip_of_service "nexus3" 1)
    script_filename=$(basename ${script_filepath})
    script_name=${script_filename%.*}
    content=$(sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' ${script})
    curl -X POST -u admin:admin123 --header "Content-Type: application/json" \
    "http://${nexus_ip}:8081/service/siesta/rest/v1/script" -d \
    "{\"name\":\"${script_name}\",\"type\":\"groovy\",\"content\":\"${content}\"}"
}

function declare_scripts () {
    script_dir=${1:?'Missing script dir as first parameter!'}
    for script in $(find ${script_dir} -name "*.groovy" -type f); do declare_script ${script}; done
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    declare_scripts $@
fi