#!/bin/sh

source /etc/ssh-tunnel/config

while [ 1 ] ; do

date
ssh ${REMOTE_USER}@${REMOTE_ADDRESS} -p ${REMOTE_CONNECT_PORT} "pkill -f 'sleep ${MUTEX_ID}'"
ssh -R 0.0.0.0:${10831}:127.0.0.1:830 ${REMOTE_USER}@${REMOTE_ADDRESS} -p ${REMOTE_CONNECT_PORT} -o ServerAliveInterval=30 -o ServerAliveCountMax=5 -o TCPKeepAlive=yes -i ~/.ssh/id_rsa sleep ${1000000001}
echo "$? : Sleep before reconnection ..."
sleep 60

done
