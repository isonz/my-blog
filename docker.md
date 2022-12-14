# 开发环境服务器 gigiapp

	docker run --restart=always -dt --name gigi-java -p 7080:8080 -p 7070:7070 -p 7060:7060 -v /media/gigi:/home/admin/apk --env LANG=C.UTF-8 gigi-java bash
	
其他参数

	docker run --restart=always -dt --name gigi_app --net host gigi_app /etc/rc.local
	docker update --restart=always 容器名字或ID

导入导出

	docker export gigiapp > gigiapp.image.tar
	docker import gigiapp.image.tar gigiapp


# mysql

安装
	
	docker pull mysql:8.0.31
	mkdir -p /data/mysql/data /data/mysql/logs /data/mysql/conf
	docker run --restart=always -p 3306:3306 --name mysql -v /data/mysql/conf:/etc/mysql/conf.d -v /data/mysql/logs:/logs -v /data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123 -d mysql:8.0.31


备份数据
	
	mysqldump --column-statistics=0 -h 120.24.93.72 -uroot -pOnionm123 --all-databases > all.sql

	mysql -h 192.168.16.100 -uroot -p123 -e "show databases;"| grep -Ev "Database|information_schema|mysql|performance_schema|test" | xargs mysqldump --column-statistics=0 -h 192.168.16.100 -uroot -p123 --databases > all.sql

恢复数据

	mysql  -h 192.168.16.100 -uroot -p123 < all.sql


# Nacos
安装

	  docker pull nacos/nacos-server:v2.1.2
	  
host 模式运行

	docker run --restart=always -d --name nacos -e PREFER_HOST_MODE=hostname -e MODE=standalone --net host nacos/nacos-server:v2.1.2

port 模式运行

	docker run --restart=always -d --name nacos -p 8848:8848 -p 9848:9848 -e PREFER_HOST_MODE=hostname -e MODE=standalone nacos/nacos-server:v2.1.2


# redis

	docker pull redis:5.0
	mkdir -p /data/redis/data
	docker run --restart=always -d --name redis5 -p 6379:6379  -v /data/redis/redis.conf:/etc/redis/redis.conf -v /data/redis/data:/data  redis:5.0 /etc/redis/redis.conf 


# mongoDB
	 
	docker pull mongo:4.2
	mkdir -p /data/mongo/db
	docker run --restart=always -d --name mongodb -p 27017:27017 -v /data/mongo/db:/data/db -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=admin888 --privileged=true mongo:4.2


# rocketMQ
	  docker pull apache/rocketmq
	  Port:9876

	 



