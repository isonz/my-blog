#!/bin/bash

# 指向到运行脚本目录
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
pwd

function dockerBuild() {
    containerName=ubm-booking
    imageName=hub.gigimed.cn:3443/gigi/${containerName}

    docker stop ${containerName}
    docker rm ${containerName}

    docker build -t ${imageName} .
    docker run --restart=always -dt --name ${containerName} -p 7001:80 --env LANG=C.UTF-8 --env TIME_ZONE=Asia/Shanghai ${imageName}

    docker image prune -f   # This command removes all dangling images.

    docker push ${imageName}

    #docker build -t hub.gigimed.cn:3443/gigi/ubm-booking .
    #docker push hub.gigimed.cn:3443/gigi/ubm-booking:v1
}

git checkout main
echo '---- Update Data -----';

check=`git pull origin main | grep 'Already up to date.'`
if [ -z "$check" ] ; then
  dockerBuild;
else
  echo 'No Code Update';
fi

