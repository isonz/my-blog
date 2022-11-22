#!/bin/bash

# usage: ./pub.sh, ./pub.sh get,  ./pub.sh upgrade , ./pub.sh outdated

# modules=("./")
for i in $( ls -d ./packages/*/)  #只显示目录
do
  modules+=("$i")   # 添加元素到数组后面
done

loopModules() {
  op=$1
  if [ "$op" == "" ] ; then
    op="get"
  fi

  for i in "${!modules[@]}";
  do
    cd "${modules[$i]}" || continue
    pwd
    flutter pub $op
    cd ../../
    # echo "${modules[$i]} $op"
  done

  flutter pub $op
}

loopModules "$1"


