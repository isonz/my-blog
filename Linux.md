# 获取 CURL 内容并判断

    #!/bin/bash

	url=http://127.0.0.1:17001/usb-on
	rson=$(curl -s $url)
	ison="usb on"
	loop=0
	loopcount=0

	while (( $loop < 1));
	do
		if [ "$rson" == "$ison" ]; then
			echo 'usb on right now';
			((loop=$loop+1));
		else
			echo "${loopcount} usb has not on"
			# 循环11次后结束
			if [ $loopcount -gt 10 ]; then
				((loop=$loop+1));
			fi
			sleep 10;
			rson=$(curl -s $url)
			echo $rson
			((loopcount=$loopcount+1));
		fi
	done;
  
  
# 通过 git pull 命令判断是否有代码更新，并构建 Docker 
  
	#!/bin/bash

	SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
	cd $SCRIPT_DIR
	pwd

	function dockerBuild() {
	    containerName=ubm-booking
	    imageName=hub.gigimed.cn:3443/gigi/${containerName}

	    docker stop ${containerName}
	    docker rm ${containerName}

	    docker build -t ${imageName} .
	    docker run --restart=always -dt --name ${containerName} -p 7001:80 --env LANG=C.UTF-8 --env TIME_ZONE=Asia/Shanghai ${imageName}

	    docker image prune -f   # This command removes all dangling images.

	    docker push ${imageName}

	    #docker build -t hub.gigimed.cn:3443/gigi/ubm-booking .
	    #docker push hub.gigimed.cn:3443/gigi/ubm-booking:v1
	}

	git checkout main
	echo '---- Update Data -----';

	check=`git pull origin main | grep 'Already up to date.'`
	if [ -z "$check" ] ; then
	  dockerBuild;
	else
	  echo 'No Code Update';
	fi


# 使用 curl 判断所有服务是否启动

	#!/bin/bash

	server_list=('127.0.0.1:7080' '127.0.0.1:9200' '127.0.0.1:9400' '127.0.0.1:9208' '127.0.0.1:9301' '127.0.0.1:9204' '127.0.0.1:9300' '127.0.0.1:9202' '127.0.0.1:9203' '127.0.0.1:9500' '127.0.0.1:9209' '127.0.0.1:9205' '127.0.0.1:9206' '127.0.0.1:9207' '127.0.0.1:9201');

	list_length=${#server_list[@]}
	#echo $list_length
	running_count=0;

	while (( $running_count < $list_length ));
	do
		running_count=0;
		for url in "${server_list[@]}"
		do
			curl_rs=$(curl -s $url)
			if [[ "$curl_rs" == "" ]]; then
				echo "$url refused"
			else
				((running_count=$running_count+1));
				echo "$url connected"
			fi
		done;
		sleep 1;
		echo -e "\n -------- end loop ------------ ";
	done;

	echo "Finished"








