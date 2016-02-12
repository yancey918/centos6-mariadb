#!/bin/bash
# Program:

CONTAINERID="${1}"
IMAGES_NAME=imagine10255/centos6-mariadb:latest
clear

until [ "$NUM" == "q" ] #輸入文字q 則離開
do
    # View
    echo -e "
Dockerfile Tools\n
[container manage]   
cc) create-container
ec) enter-container
ic) install-container

[images manage]
bi) build-images
pi) push-images
di) delete-images
"
    read NUM
    case $NUM in
    cc)
        docker run -it ${IMAGES_NAME} bash
        exit;
    ;;
    ec)
        if [ "$CONTAINERID" == "" ]; then
           echo ">> please keyin {Container-id or Name}";
           exit;
        fi
        docker exec -it ${CONTAINERID} bash
    ;;
    ic)
        if [ "$CONTAINER" == "" ]; then
           echo ">> please enter container new-name";
           exit;
        fi

        # create docker-container
        docker run -idt \
        --name "$CONTAINER" \
        -p 3306:3306 \
        -p 22:3322 \
        -v /home/tmp:/home/tmp \
        -v /home/mariadb:/home/mariadb \
        ${IMAGES_NAME}

        # enter docker-container
        docker exec -it ${CONTAINERID} bash
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

