#!/bin/bash

doGit() {
	git checkout dev
	git pull origin dev
	git checkout master
	git pull origin master
	echo "------ 提交到 gitlab  ---------"
	git push mirror master
	git checkout dev
	git push mirror dev
}

echo "------ 正在处理 Admin  ---------"
cd "admin"
doGit
echo "------ Admin 处理完毕  ---------"

cd "../"

echo "------ 正在处理 Client  ---------"
cd "client"
doGit
echo "------ Client 处理完毕  ---------"

cd "../"

echo "------ 正在处理 Cloud  ---------"
cd "cloud"
doGit
echo "------ Cloud 处理完毕  ---------"

cd "../"

echo "------ 正在处理 M  ---------"
cd "m"
doGit
echo "------ M 处理完毕  ---------"





# cron_gitlab.sh

bak_dir=/data/backup/gitlab/gz;

date_now=`date +%Y`-`date +%m`-`date +%d`;

tar zcvf gz/gitlab_$date_now.tar.gz /data/backup/gitlab/v3/

find $bak_dir -mtime +10 -name "*.*" -exec rm -rf {} \;

