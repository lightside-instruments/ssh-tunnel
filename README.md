# SSH tunneling

Here are the steps to configure a server for SSH tunneling of ports (in the example port 22 of remote devices without public IP are mapped to a local port on a server with public IP) so that a remote client connecting to the public port on the server is indeed connecting to the tunneled port of the device.

## On remote device


As root:

```
ssh-keygen -t rsa -b 4096 -m PEM -f ~/.ssh/id_rsa -N ""
```

Edit ./config and copy the file to /etc/ssh-tunnel/config

Test by starting manually:
```
/root/ssh-tunnel/ssh-tunnel.sh
```

Edit /etc/rc.local:
```
/root/ssh-tunnel/ssh-tunnel.sh 1>>/var/log/ssh-tunnel.stdout 2>>/var/log/ssh-tunnel.stderr &
```

Reboot.

## On tunneling/forwarding server with public ip

Add following lines to /etc/ssh/sshd_config:
```
...
PermitTunnel yes
GatewayPorts clientspecified
ClientAliveInterval 30
ClientAliveCountMax 3
...
```
Restart the ssh server:
```
sudo /etc/init.d/ssh restart
```
Add one user per remote device. This is how you add one.
```
sudo adduser vpn001 --disabled-password
sudo su vpn001
cd
mkdir .ssh
vi .ssh/authorized_keys
... paste pub key /root/.ssh/id_rsa.pub from device ...
```

Your server is ready to tunnel connections from clients from the public address  to the client.

## On remote client
```
ssh myserver.com -p 22001
```
