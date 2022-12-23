# 开发环境服务器 gigi-java

	docker run --restart=always -dt --name gigi-java -p 7080:8080 -p 7070:7070 -p 7060:7060 -v /www/apk:/home/admin/apk -v /home/onion/gigi-java/logs:/home/admin/app/logs -v /home/onion/gigi-java/logs/ons:/root/logs --env LANG=C.UTF-8 gigi-java bash
	
	docker exec -it gigi-java bash
	
其他参数

	docker run --restart=always -dt --name gigi_app --net host gigi_app /etc/rc.local
	docker update --restart=always 容器名字或ID

导入导出

	docker export gigi-java > gigi-java.image.tar
	docker import gigi-java.image.tar gigi-java

	docker save ubuntu > /data/backup/docker/ubuntu.image.tar
	docker load < /data/backup/docker/ubuntu.image.tar

# 开发环境 Android App打包

	docker run --restart=always -dt --name gigi-app-android -v /www/apk:/app/apk --env LANG=C.UTF-8 --env TZ=Asia/Shanghai gigi-app-android bash
	
	docker exec -it gigi-app-android bash
	
# 开发环境 iOS App打包

	docker run --restart=always -dt --name gigi-app-ios -v /www/ipa:/app/ipa --env LANG=C.UTF-8 --env TZ=Asia/Shanghai gigi-app-ios bash
	
	docker exec -it gigi-app-ios bash
	

# mysql

安装
	
	docker pull mysql:8.0.31
	mkdir -p /data/mysql/data /data/mysql/logs /data/mysql/conf
	docker run --restart=always --net host --name mysql -v /data/mysql/conf:/etc/mysql/conf.d -v /data/mysql/logs:/logs -v /data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Onionm123 -d mysql:latest


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

	docker run --restart=always -d --name nacos -p 8848:8848 -p 9848:9848 -e PREFER_HOST_MODE=hostname -e MODE=standalone gigi-nacos:v1

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

	 
# Login登录凭证安全存储
下载 用到的工具 docker-credential-helpers：https://github.com/docker/docker-credential-helpers/releases ，并命名为 docker-credential-pass
	
	chmod +x docker-credential-pass
	mv docker-credential-pass /usr/local/bin/

清空 /root/.docker/config.json文件内容，然后将下面配置写入config.json文件中

	{ "credsStore": "pass"}

检查gpg，并生成秘钥，过程中输入的账号和密码要用 harbor 的账号和密码，比如 admin 
	
	gpg --version
	gpg --gen-key
	gpg --list-keys
	
	export GPG_TTY=$(tty)
	
安装pass

	apt install -y pass
	pass version
	apt-get install rng-tools

	pass init admin		 [admin 是gen-key输入的账号，也是harbor的账号]
	
登入 harbor 验证

	docker login hub.gigimed.cn:3443 -u admin

最终 /root/.docker/config.json 的内容如下：

	{
        	"auths": {
                	"https://hub.gigimed.cn:3443": {},
                	"hub.gigimed.cn:3443": {}
        	},
        	"HttpHeaders": {
                	"User-Agent": "Docker-Client/20.10.12"
        	},
        	"credsStore": "pass"
	}







