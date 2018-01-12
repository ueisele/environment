#!/usr/bin/env bash
set -e
DIR=$(cd $(dirname $0); pwd)
pushd . > /dev/null
cd $DIR
source ./docker-compose.sh
popd > /dev/null

function main() {
    docker_compose_in_environment down -v --remove-orphans
}

main