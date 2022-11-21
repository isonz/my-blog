# 开发环境服务器 gigiapp

	docker run --restart=always -dt --name gigiapp -p 7080:8080 -p 7070:7070 -p 7060:7060 -v /media/gigi:/home/admin/apk --env LANG=C.UTF-8 gigiapp
	
其他参数

	docker run --restart=always -dt --name gigi_app --net host gigi_app /etc/rc.local
	docker update --restart=always 容器名字或ID


# Nacos

	  docker pull nacos/nacos-server:v2.1.0
	  docker run -d --name nacos -p 8848:8848 -p 9848:9848 -e PREFER_HOST_MODE=hostname -e MODE=standalone --net host nacos/nacos-server:v2.1.0

	  docker restart 8149bca96437

	  docker pull mysql:5.7
	  mkdir -p /data/mysql/data /data/mysql/logs /data/mysql/conf
	  docker run -p 3306:3306 --name mysql -v /data/mysql/conf:/etc/mysql/conf.d -v /data/mysql/logs:/logs -v /data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Onionm123 -d mysql:5.7

	  docker pull apache/rocketmq
	  Port:9876

	  docker pull redis:5.0
	  Port:6379

	  docker pull mongo:4.2
	  Port:27017



