# MySQL8开启远程访问权限

	mysql -u root -p
	use mysql;
	update user set host = '%' where user = 'root';
	FLUSH PRIVILEGES;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
	select host,user,plugin from user;

# 修改密码
	# plugin需要是mysql_native_password
	alter user 'root'@'%' identified with mysql_native_password by 'your_password';
	
