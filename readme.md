# Jenkins runs in Docker, can run Docker commands

## access to host docker
> you can map /var/run/docker.sock to /var/run/docker.sock as a persistent volume and it should work

also see: https://stackoverflow.com/questions/51342810/how-to-fix-dial-unix-var-run-docker-sock-connect-permission-denied-when-gro

## permission to host docker

```
sudo setfacl -m user:1000:rw /var/run/docker.sock
```

Run the above every time the host reboots.
