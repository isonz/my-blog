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
	sleep 5;
	echo -e "\n -------- end loop ------------ ";
done;

# curl -s http://183.6.57.47:17001/green

echo -e "\nFinished"

