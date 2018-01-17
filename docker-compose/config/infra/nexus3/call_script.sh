#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
source ../../../ips.sh
popd > /dev/null

function call_script () {
    script=${1:?'Missing script name as first parameter!'}
    content=${2:?'Missing content as second parameter!'}
    nexus_ip=$(ip_of_service "nexus3" 1)
    curl -X POST -u admin:admin123 --header "Content-Type: text/plain" \
    "http://${nexus_ip}:8081/service/siesta/rest/v1/script/${script}/run" -d ${content}
}