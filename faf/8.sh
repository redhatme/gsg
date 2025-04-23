#!/bin/bash
#autor:淘宝：HA智能家居店

RED_COLOR='\033[0;31m'
GREEN_COLOR='\033[0;32m'
GREEN_YELLOW='\033[1;33m'
NO_COLOR='\033[0m'


function info () { echo -e "${GREEN_COLOR} $1${NO_COLOR}";}
function warn () { echo -e "${GREEN_YELLOW} $1${NO_COLOR}";}



if [ -n "$1" ]; then
    download_url="https://gitee.com/redhatme/hashell/releases/download/$1/$1.zip"
    getfile1="$1.zip"
    getfile2="$1"
else
    # 如果$1为空，则打印消息并退出脚本
    echo "参数为空，脚本退出。"
    exit 1
fi



# 检测 unzip 是否安装
if [ -z "$(command -v "unzip")" ]; then
    info "开始安装unzip"
    apt-get -y install unzip
fi

#查找HA的安装目录
hafile1="/var/lib/homeassistant/homeassistant/configuration.yaml"
hafile2="config/configuration.yaml"

if [ -f $hafile1 ]; then
    hadir="/var/lib/homeassistant/homeassistant/custom_components"
    if [ ! -d $hadir ]; then
        mkdir $hadir
    fi

elif [ -f $hafile2 ]; then
    hadir="config/custom_components"
    if [ ! -d $hadir ]; then
        mkdir $hadir   
    fi
else
    hadir="zero"
    echo  "没有ha的目录退出"
    exit 1
fi


file3="$hadir/__MACOSX"
if [ -d $file3 ]; then
    echo "正在删除$file3"
    rm -rf $file3
fi

if [ $hadir != "zero" ]; then

    cd  $hadir
    info "开始下载$getfile1文件"
    wget  $download_url
    if [ -f "$getfile1" ]; then
        echo "文件$getfile1 下载完毕"
    else
        echo "再次尝试下载"
        wget  $download_url
    fi

    if [ -f "$getfile1" ]; then
        echo " "
    else
        echo "下载不成功$getfile1,退出。。"
        exit 2
    fi

    rm  -rf $getfile2 
    info "正在解压 $getfile1 "
    unzip $getfile1 
    echo "正在删除$getfile1"
    rm $getfile1
    info "恭喜，$getfile2 安装成功 ！！！！！"
    warn "回到homeassistant的页面，点击左侧，【开发者工具】，【重新启动】（黄色的重新启动就行）"
    warn "等重新启动完了就可以了^_^"

fi

