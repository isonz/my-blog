#!/bin/bash

# usage:
# git commit: ./push.sh 'commit message'
# set nacos group to DEFAULT_GROUP: ./push.sh set default
# set nacos group to my name: ./push.sh set my


modules=("gigi-auth" "gigi-gateway" "gigi-visual/gigi-monitor")
for i in $( ls -d gigi-modules/*/)  #只显示目录
do
  modules+=("$i")   # 添加元素到数组后面
done

loopModules() {
  for i in "${!modules[@]}";
  do
    changeGroup "${modules[$i]}" "$1"
    # echo "${modules[$i]}"
  done
}

changeGroup(){
  filename=$1/src/main/resources/bootstrap.yml
  groupName=$(git config user.name)
  myGroupStr="group: $groupName"
  defaultGroupStr="group: DEFAULT_GROUP"

  if [ "$2" == "default" ]; then
    echo "------ $1 恢复为 $defaultGroupStr 参数 ---------"
    sed -i "" "s/$myGroupStr/$defaultGroupStr/g" "$filename"
  fi

  if [ "$2" == "my" ]; then
     echo "------ $1 更新为 $myGroupStr 参数 ---------"
     sed -i "" "s/$defaultGroupStr/$myGroupStr/g" "$filename"
  fi

}

gitPush() {
    useBranch="dev"
    echo "------ git checkout $useBranch ---------"
    git checkout "$useBranch"

    loopModules default

    echo "------ 提交本分支 ---------"
    echo "------ git add --all ---------"
    git add --all
    echo "------ git commit -m $commitMessage ---------"
    git commit -m "$commitMessage"
    echo "------ git pull origin $useBranch ---------"
    git pull origin "$useBranch"
    echo "------ git push origin $useBranch ---------"
    git push origin "$useBranch"

    loopModules my
}


commitMessage=$1
if [ "$commitMessage" == "" ] ; then
  echo "请输入 commit 信息"
  exit
elif [ "$commitMessage" == "set" ] ; then
  if [ "$2" == "default" ] ; then
    loopModules default
  elif [ "$2" == "my" ]; then
    loopModules my
  fi
else
  gitPush
fi



# updateGroup "${modules[$i]}" "add"
# updateGroup "${modules[$i]}" "remove"
updateGroup(){
  groupName=$(git config user.name)
  groupStr="group: $groupName"
  filename=$1/src/main/resources/bootstrap.yml
  markStr='# 服务注册地址'
  markStrLine=$(awk "/$markStr/{ print NR; exit }" "$filename")   # 找出 '服务注册地址' 所在的行数
  insertLine=$(($markStrLine+2))  # 行数+2
  # echo "$markStrLine"
  # echo "$insertLine"
  # currentPath=$(pwd)

  readInsertLine=$(sed -n "${insertLine}p" "$filename") # 读取改行的字符串
  echo "$readInsertLine"

  if [[ "$readInsertLine" == *"group"* ]]; then   # 对比改行是否含有 group 字符串
    if [ "$2" = "remove" ]; then
      echo "------ $1 删除 group 参数 ---------"
      sed -i "" -e "${insertLine}d" "$filename"     # 删除改行
    else
      echo "------ $1 已经有 group 参数 ---------"
    fi
  else
    if [ "$2" = "add" ]; then
       echo "------ $1 插入 group 参数 ---------"
       sed -i "" -e "${insertLine}i\\
        $groupStr
        " "$filename"
    fi
  fi
}
