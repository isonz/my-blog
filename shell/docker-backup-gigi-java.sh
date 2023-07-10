#!/bin/bash

# docker export gigi-java > /data/backup/docker/gigi-java.image.tar

# docker import gigiapp.image.tar gigiapp

# docker commit gigiapp gigiapp
# docker save gigiapp > gigiapp.image.tar

imagename=gigi-java
backpath=/data/backup/docker

if [ "$1" == "restore" ]; then
	echo "------ 正在 export ${imagename} ---------"
	docker export ${imagename} > ${backpath}/${imagename}.image.r.tar
	docker stop ${imagename}
	docker rm ${imagename}
	docker rmi ${imagename}

	echo "------ 正在 import ${imagename} ---------"
	docker import ${imagename}.image.r.tar ${imagename}

	# echo "------ 正在 run ${imagename} ---------"
	# docker run --restart=always -dt --name ${imagename} -p 7080:8080 -p 7070:7070 -p 7060:7060 -v /www/apk:/home/admin/apk -v /home/onion/${imagename}/logs:/home/admin/app/logs -v /home/onion/${imagename}/logs/ons:/root/logs --env LANG=C.UTF-8 ${imagename} bash

	# docker exec -it ${imagename} bash

else	
	echo "------ 执行备份镜像  ---------"
	docker export ${imagename} > ${backpath}/${imagename}.image.tar
fi



