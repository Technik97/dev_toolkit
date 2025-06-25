#! /bin/bash 

if [ -z "$1" ]; then 
    echo "Usage: $0 <container-name> [--root]"
    exit 1
fi 

if [ "$2" ==  "--root" ]; then 
    sudo docker exec -it -u root "$1" bash
else 
    sudo docker exec -it "$1" bash
fi
