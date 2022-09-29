#!/bin/bash

# Run this so that jenkins inside the docker container can also run docker
sudo setfacl -m user:1000:rw /var/run/docker.sock
