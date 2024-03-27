# MySQL8开启远程访问权限

	mysql -u root -p
	use mysql;
	update user set host = '%' where user = 'root';
	FLUSH PRIVILEGES;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	select host,user,plugin from user;
	
# 修改mysql的绑定地址，注释 127.0.0.1
	vim  /etc/mysql/mysql.conf.d/mysqld.cnf
		
	# bind-address          = 127.0.0.1
	mysqlx-bind-address     = 127.0.0.1

# 修改密码
	# plugin需要是mysql_native_password
	alter user 'root'@'%' identified with mysql_native_password by 'your_password';
	

# 导出数据库
导出所有数据库，包括系统数据库

	mysqldump --column-statistics=0 -h 192.168.16.100 -uroot -pxxxx --all-databases > all.sql
	
导出所有数据库，排除系统数据库

	mysql -h 192.168.16.100 -uroot -pxxx -e "show databases;"| grep -Ev "Database|information_schema|mysql|performance_schema|test" | xargs mysqldump --column-statistics=0 -h 192.168.16.100 -uroot -pxxxx --databases > all.sql
	
# 每天自动导出数据库并备份，删除10天前的备份，恢复备份的数据 
/data/mysql.backup.sh

	#!/bin/bash
	
	dir=/data/backup/mysql/
 	host=192.168.16.100
  	user=root
	pwd=123456

 	mysql -h ${host} -u${user} -p${pwd} -e "show databases;"| grep -Ev "Database|information_schema|mysql|performance_schema|test" | xargs mysqldump --column-statistics=0 -h ${host} -u${user} -p${pwd} --databases | gzip > ${dir}/$(date +%Y-%m-%d)-all.sql.gz
  
	find $dir -type f -name "*.gz" -mtime +30 -print | xargs rm -rf
	
	# mysql -h 192.168.16.100 -uroot -p123456 -e "show databases;"| grep -Ev "Database|information_schema|mysql|performance_schema|test" | xargs mysqldump --column-statistics=0 -h 192.168.16.100 -uroot -p123456 --databases > ${dir}/all.sql
	# tar zcvf data/all-$(date +%Y-%m-%d).tar.gz data/all.sql
	# find $dir -type f -name "*.gz" -mtime +30 -print | xargs rm -rf
	
单个单个数据库操作
	
	mysqldump -u root -p --databases database_name_a database_name_b > databases_a_b.sql
	
crontab -e 

	* 01 * * *      /data/backup/mysqlmysql.backup.sh
	
# 恢复数据
/data/mysql.restore.sh
	
	#!/bin/bash

	# usage: ./mysql.restore.sh 2022-11-22

	if [ "$1" == "" ] ; then
		echo "请输入时间"
		exit
	fi

	dir=/data/backup/mysql/data
	file=$1-all.sql.gz
	gzip -d $dir/$file
	mysql  -h 192.168.16.100 -uroot -p123456 < $dir/$1-all.sql
	

全部恢复

	mysql  database_name < file.sql

单个数据库
	
	# 从备份的全部数据库中恢复制定的数据库 
	mysql --one-database database_name < all_databases.sql
	
	# 恢复单个数据库
	mysql -u root -p -e "create database database_name";
	mysql -u root -p database_name < database_name.sql


从一个数据库直接备份到另一个数据库

	mysqldump -u root -p database_name | mysql -h remote_host -u root -p remote_database_name



