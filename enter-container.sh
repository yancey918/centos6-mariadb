#!/bin/bash

CONTAINERID="${1}";

if [ "$CONTAINERID" == "" ]; then
echo "please keyin {Container-id or Name}";
echo "ex: sh enter-docker.sh mariadb";
exit;
fi

docker exec -it $CONTAINERID bash
