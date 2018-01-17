#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
source ./call_script.sh
popd > /dev/null

function create_repo_docker_hosted () {
    name=${1:?'Missing repository name as first parameter!'}
    http_port=${2:?'Missing port as second parameter!'}
    blob_store=${3:?'Missing blob store as third parameter!'}
    call_script "create_repo_docker_hosted" "{\"name\":\"${name}\",\"http_port\":\"${http_port}\",\"blob_store\":\"${blob_store}\"}"
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    create_repo_docker_hosted "$@"
fi