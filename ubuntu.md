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
