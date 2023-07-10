#!/bin/bash

docker export gigi-java-1 > /data/backup/docker/gigi-java.image.tar

docker export dova-algor > /data/backup/docker/dova-algor.image.tar

docker export dova-redis5 > /data/backup/docker/dova-redis5.image.tar

docker export gigi-app-android > /data/backup/docker/gigi-app-android.image.tar

docker export mongodb > /data/backup/docker/mongodb.image.tar

docker export redis5 > /data/backup/docker/redis5.image.tar

docker export nacos > /data/backup/docker/nacos.image.tar

docker export mysql > /data/backup/docker/mysql.image.tar

docker save ubuntu > /data/backup/docker/ubuntu.image.tar

#docker commit es01 gigi-es01
#docker save gigi-es01 > /data/backup/docker/gigi-es01.image.tar

#docker commit kibana gigi-kibana
#docker save gigi-kibana > /data/backup/docker/gigi-kibana.image.tar



# docker import gigiapp.image.tar gigiapp
# docker commit gigiapp gigiapp
# docker save gigiapp > gigiapp.image.tar

