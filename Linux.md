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
  
  
  
