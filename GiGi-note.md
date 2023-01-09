# 流水线部署参数设置
JAVA
		
	/home/admin/app/package.tgz
	bash /home/admin/app/restart_all.sh
		
App

	/app/mobile/package.tgz
	bash /app/mobile/run.sh
		

H5

	/home/admin/m.gigimed.cn/package.tgz
	tar zxvf /home/admin/m.gigimed.cn/package.tgz -C /home/admin/m.gigimed.cn/
	
Admin

	/home/admin/admin.gigimed.cn/package.tgz
	tar zxvf /home/admin/admin.gigimed.cn/package.tgz -C /home/admin/admin.gigimed.cn/


Gateway & Auth

	/home/admin/app/package.tgz
	tar zxvf /home/admin/app/package.tgz -C /home/admin/app/
	bash /home/admin/app/deploy.sh restart gigi-gateway
	# sh /home/admin/app/deploy.sh restart gigi-auth



		
删除阿里云自主部署主机服务 staragent
		
	/home/staragent/bin/staragentctl stop;
	rm -rf /home/staragent;
	rm /usr/sbin/staragent_sn

		
# 青才服务器

	mkdir -p /data/dova-redis/data
	docker run --restart=always -d --net dovanet --ip 172.12.12.4 --cpus=2 -m=4096m --name dova-redis5 -p 6378:6379  -v /data/dova-redis/redis.conf:/etc/redis/redis.conf -v /data/dova-redis/data:/data  redis5 /etc/redis/redis.conf

	docker run --restart=always -dt --net dovanet --ip 172.12.12.101 --cpus=4 -m=16384m --name dova-algor -p 6023:6023 -p 6024:6024 -p 6025:6025 -p 6022:22 -v /home/onion/dova-algor:/home/dova-algor --env LANG=C.UTF-8 dova-algor bash


	Redis
	version :  5.0
	公网IP：183.6.57.47   端口： 6378
	内网IP:   172.12.12.4   端口： 6379
	登入账号：无				登入密码: mima

	Ubuntu 
	version:  22.04
	公网IP：183.6.57.47   	SSH端口： 6022 ,  预留端口 6023-6025
	内网IP:   172.12.12.101   SSH端口： 22
	账号：root						密码：	Onionm123


