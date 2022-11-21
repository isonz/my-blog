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
导出所有数据库

	mysqldump --column-statistics=0 -h 192.168.16.100 -uroot -pxxxx --all-databases > all.sql
	

