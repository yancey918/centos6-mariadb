#!/bin/bash

AUTHOR=imagine10255
IMAGE_NAME=centos6-mariadb
VERSION=latest
FULL_NAME=$AUTHOR/$IMAGE_NAME:$VERSION

display_container()
{
    clear
    docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}"
    echo ""
}

create_container()
{
    docker run -idt \
    --name "$2" \
    -p 3306:3306 \
    -p 3322:22 \
    -v /home/tmp:/home/tmp \
    -v /home/mysql:/home/mysql \
    $1
}


clear

until [ "$NUM" == "q" ] #輸入文字q 則離開
do
    # View
    echo -e "
Dockerfile Tools

[container manage]   
cc) create  container
ec) enter   container
ic) install container
ps) display container

[images manage]
bi) build  images
pi) push   images
di) delete images
"
    read -p "Enter your choice: " NUM
    case $NUM in
    cc)
        clear
        docker run -idt ${FULL_NAME} bash
    ;;
    ec)
        display_container
        read -p "Enter Container ID or Name: " CONTAINERID
        case $CONTAINERID in
        *)
            docker exec -it ${CONTAINERID} bash
        ;;esac
    ;;
    ic)
        display_container
        read -p "Rename Container or Enter empty(default: centos6-mariadb): " NEW_CONTAINER_NAME
        case $NEW_CONTAINER_NAME in
        *)
            if [ "$NEW_CONTAINER_NAME" == "" ]; then
               NEW_CONTAINER_NAME=$IMAGE_NAME
            fi
            
            create_container ${FULL_NAME} ${NEW_CONTAINER_NAME}

            # enter docker-container
            docker exec -it "$NEW_CONTAINER_NAME" bash
        ;;esac
    ;;
    ps) 
        display_container
    ;;
    bi)
        clear
        docker build -t ${FULL_NAME} .
    ;;
    pi)
        docker push ${FULL_NAME}
    ;;
    di)
        clear
        docker rmi `docker images | grep "^<none>" | awk '{print $3}'`
    ;;
    q)
        exit;
    ;;
    *) 
        echo ">> Please keyin true option" && exit ;;esac	
done
