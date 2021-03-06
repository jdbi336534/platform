#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )

if [[ -z "$2" ]]; then
    echo "usage $0 [start|stop] [internal|api]"
    exit 1
fi

case $1 in
start)
    $DIR/nginx/sbin/nginx -c ${SNAP_COMMON}/config/nginx/$2.conf
    ;;
post-start)
    timeout 5 /bin/bash -c 'until echo > /dev/tcp/localhost/81; do sleep 1; done'
    ;;
reload)
    $DIR/nginx/sbin/nginx -c ${SNAP_COMMON}/config/nginx/$2.conf -s reload
    ;;
stop)
    $DIR/nginx/sbin/nginx -c ${SNAP_COMMON}/config/nginx/$2.conf -s stop
    ;;
*)
    echo "not valid command"
    exit 1
    ;;
esac


