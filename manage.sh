#!/bin/bash
# Program:

IMAGES_NAME=imagine10255/centos6-mariadb:latest
clear

until [ "$NUM" == "q" ] #輸入文字q 則離開
do
    # View
    echo -e "
Dockerfile Tools

[container manage]   
cc) create-container
ec) enter-container
ic) install-container

[images manage]
bi) build-images
pi) push-images
di) delete-images
"
    read -p "Enter your choice: " NUM
    case $NUM in
    cc)
        docker run -it ${IMAGES_NAME} bash
        exit;
    ;;
    ec)
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}"
        echo ""
        read -p "Enter Container ID or Name: " CONTAINERID
        case $CONTAINERID in
        *)
            docker exec -it ${CONTAINERID} bash
        ;;esac
    ;;
    ic)
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}"
        echo ""
        read -p "Rename Container: " NEW_CONTAINER_NAME
        case $NEW_CONTAINER_NAME in
        *)
            if [ "$NEW_CONTAINER_NAME" == "" ]; then
               echo ">> please enter container new-name";
               exit;
            fi
            
             # create docker-container
             docker run -idt \
             --name "$NEW_CONTAINER_NAME" \
             -p 3306:3306 \
             -p 22:3322 \
             -v /home/tmp:/home/tmp \
             -v /home/mysql:/home/mysql \
             ${IMAGES_NAME}

             # enter docker-container
             docker exec -it "$NEW_CONTAINER_NAME" bash
 
        ;;esac
    ;;
    bi)
        docker build -t ${IMAGES_NAME} .
    ;;
    pi)
        docker push ${IMAGES_NAME}
        exit;
    ;;
    di)
        docker rmi `docker images | grep "^<none>" | awk '{print $3}'`
        exit;
    ;;
    q)
        exit;
    ;;
    *) 
        echo ">> Please keyin true option" && exit ;;esac	
done
