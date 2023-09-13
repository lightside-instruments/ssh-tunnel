#!/usr/bin/bash

source /etc/ssh-tunnel/config


while [ 1 ] ; do

date
ssh ${REMOTE_USER}@${REMOTE_ADDRESS} -p ${REMOTE_CONNECT_PORT} "pkill -f 'sleep ${MUTEX_ID}'" || true
ssh -R 0.0.0.0:${REMOTE_LISTEN_PORT}:127.0.0.1:${REMOTE_CONNECT_PORT} ${REMOTE_USER}@${REMOTE_ADDRESS} -p ${REMOTE_CONNECT_PORT} -o ServerAliveInterval=30 -o ServerAliveCountMax=5 -o TCPKeepAlive=yes -i ~/.ssh/id_rsa sleep ${MUTEX_ID}
echo "$? : Sleep before reconnection ..."
sleep 60

done
