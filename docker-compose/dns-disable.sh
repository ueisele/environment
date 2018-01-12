#!/usr/bin/env bash
set -e
pushd . > /dev/null
cd $(dirname ${BASH_SOURCE[0]})
source ./docker-compose.sh
popd > /dev/null

function dns_disable () {
    remove_dns_from_host_dnsmasq ${CONSUL_DOMAIN_NAME}

    remove_dns_from_host_dnsmasq ${DOMAIN_NAME}
    stop_service "dns"
}

function remove_dns_from_host_dnsmasq () {
    domain_name=$1
    sudo rm /etc/NetworkManager/dnsmasq.d/docker_${PROJECT_NAME}_${domain_name}.conf
    sudo systemctl restart NetworkManager
}

function stop_service () {
    docker_compose_in_environment stop $1
}

if [ "${BASH_SOURCE[0]}" == "$0" ]; then
    dns_disable
fi
