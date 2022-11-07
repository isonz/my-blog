# 添加根证书
	cp 证书名称.crt /usr/local/share/ca-certificates
	update-ca-certificates

	# update-ca-certificates命令将PEM格式的根证书内容附加到/etc/ssl/certs/ca-certificates.crt 
	# 而/etc/ssl/certs/ca-certificates.crt 包含了系统自带的各种可信根证书.
 
# 删除根证书：
	rm -f /usr/local/share/ca-certificates/证书名称.crt
	update-ca-certificates
# 查看所有根证书
	awk -v cmd='openssl x509 -noout -subject' ' /BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt



# rc.local运行
vim /lib/systemd/system/rc-local.service  最后添加如下代码

	[Unit]
	.....

	[Service]
	....

	[Install]
	WantedBy=multi-user.target
	Alias=rc-local.service
	
vim /etc/rc.local

 	#!/bin/sh
	
	# 这里添加要开机执行的脚本和命令等等
	
	exit 0
	
最后：

	chmod +x /etc/rc.local
 	ln -s /lib/systemd/system/rc-local.service /etc/systemd/system/rc-local.service
重启生效。


# 配置免密登录
1、输入如下命令，连敲三个回车

	ssh-keygen -t rsa

2、输入如下命令，回车

	ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.50.50 

3、输入第二台服务器密码验证即可实现免密登录





