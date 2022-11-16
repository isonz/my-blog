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


# Mount

	#!/bin/bash
	mount -t cifs  -o username=ison,password=zhang //192.168.16.143/ison/back /media/back

# 单网卡配置双IP

vim /etc/iproute2/rt_tables  添加
	
	800 second_ip

vim /etc/netplan/00-installer-config.yaml
	
	network:
	  ethernets:
	    enp2s0:
	      dhcp4: no
	      dhcp6: no
	      addresses: [192.168.50.100/24, 192.168.16.100/24]
	      # gateway4:  192.168.50.1
	      routes:
		- to: 0.0.0.0/0
		  via: 192.168.50.1
		- to: 0.0.0.0/0
		  via: 192.168.16.1
		  table: 800
	      routing-policy:
		- from: 192.168.16.100
		  table: 800
	      nameservers:
		addresses: [180.76.76.76, 223.5.5.5]
	  version: 2
	  renderer: networkd
	
重启netplan

	netplan apply

# 单网卡配置IP
vim /etc/netplan/00-installer-config.yaml

	network:
	  ethernets:
	    enp2s0:
	      dhcp4: no
	      dhcp6: no
	      addresses: [192.168.50.100/24]
	      routes:
		- to: 0.0.0.0/0
		  via: 192.168.50.1
	      nameservers:
		addresses: [180.76.76.76, 223.5.5.5]
	  version: 2
	  renderer: networkd

重启netplan

	netplan apply
	











