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

		
