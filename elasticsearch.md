# 安装 elasticsearch:8.6.1
### 1、获取镜像
	docker pull docker.elastic.co/elasticsearch/elasticsearch:8.6.1

### 2、创建单独的网络
	docker network create elastic
	
### 3、运行容器
	docker run --restart=always -d \
	--hostname es01.gigimed.cn --name es01 --net elastic \
	-p 9200:9200 \
	-v /www/elasticsearch/data:/usr/share/elasticsearch/data \
	docker.elastic.co/elasticsearch/elasticsearch:8.6.1

或关闭安全认证：
	
	docker run --restart=always -d --hostname es01.gigimed.cn --name es01 --net elastic \
	-p 9200:9200 -p 9300:9300   \
	-e "discovery.type=single-node" \
	-e "xpack.security.enabled=false"   \
	-v /www/elasticsearch/data:/usr/share/elasticsearch/data \
	docker.elastic.co/elasticsearch/elasticsearch:8.6.1
	
*  需要注意的是,命令中所有 valume 目录都必须是 777权限，否则无法写入。  
*  验证过 /usr/share/elasticsearch/config 目录无法外挂到容器外，里面依赖的文件太多。

### 4、导出证书
	docker cp es01:/usr/share/elasticsearch/config/certs/http_ca.crt .
	
### 5、设置 elastic 密码
	docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic
	
### 6、本地验证登入是否成功
	curl --cacert http_ca.crt -u elastic https://localhost:9200
	
远程访问也可以，只是证书会提示不安全，访问 https://192.168.16.100:9200 输入 elastic 密码即可
	
### 7、创建节点 token 
	docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s node
	
### 8、本地docker 添加节点
	docker run -d -e ENROLLMENT_TOKEN="<token>" --name es02 --net elastic -it docker.elastic.co/elasticsearch/elasticsearch:8.6.1


	
# 安装 Kibana
### 1、安装 kibana docker 
	docker run --restart=always -d --name kibana --net elastic -p 5601:5601 docker.elastic.co/kibana/kibana:8.6.1
	
或者指定本地的配置文件

	docker run --restart=always -d --name kibana --net elastic \
	-p 5601:5601 \
	-v /www/elasticsearch/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml \
	docker.elastic.co/kibana/kibana:8.6.1


### 2、创建账户 kibana_system 的密码
	docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system

### 3、创建 kibana for elasticsearch 的注册 token
	docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana
	
访问 http://192.168.16.100:5601/ ，选用 token 的方式进行注册。填入步骤 2、3中的账号和密码及 token 即可。

### 4、创建证码
	docker exec -it kibana /usr/share/kibana/bin/kibana-verification-code









