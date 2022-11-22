#!/bin/bash

commitMessage=$1
if [ "$commitMessage" = "" ] ; then
  echo "请输入 commit 信息"
  exit
fi


useBranch=$(git symbolic-ref --short -q HEAD)
echo "------ Current branch is $useBranch ---------"

echo "------ 提交本分支 ---------"
echo "------ git add --all ---------"
git add --all
echo "------ git commit -m $commitMessage ---------"
git commit -m "$commitMessage"
echo "------ git pull origin $useBranch ---------"
git pull origin "$useBranch"


echo "------ 合并主干 ---------"
echo "------ git checkout main ---------"
git checkout main
echo "------ git pull origin main ---------"
git pull origin main
echo "------ git checkout $useBranch ---------"
git checkout "$useBranch"
echo "------ git merge main ---------"
git merge main


echo "------ 提交并PUSH合并主干后的本分支 ---------"
echo "------ git commit -m merge main for - $commitMessage ---------"
git commit -m "merge main for - $commitMessage"
echo "------ git push origin $useBranch ---------"
git push origin "$useBranch"


echo "------ 把本分支合并到主干 ---------"
echo "------ git checkout main ---------"
git checkout main
echo "------ git pull origin main ---------"
git pull origin main
echo "------ git merge $useBranch ---------"
git merge "$useBranch"


echo "------ 提交合并后的主干  ---------"
echo "------ git commit -m merge main for - $commitMessage  ---------"
git commit -m "merge $useBranch for - $commitMessage"
echo "------ git push origin main ---------"
git push origin main


echo "------ 返回本分支 ---------"
echo "------ git checkout $useBranch ---------"
git checkout "$useBranch"
