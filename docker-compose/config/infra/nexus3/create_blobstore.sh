#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
source ./call_script.sh
popd > /dev/null

function create_blobstore () {
    name=${1:?'Missing blobstore name as first parameter!'}
    call_script "create_blobstore" "{\"name\":\"${name}\",\"path\":\"/nexus-data/blobs/${name}\"}"
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    create_blobstore "$@"
fi