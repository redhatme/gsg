#!/bin/bash

# 定义变量
FILENAME="miot_client.py"
URL="https://gitee.com/redhatme/ha/releases/download/miot/miot_client.py"

# 判断并设置目标目录
if [ -f "/usr/share/hassio/homeassistant/configuration.yaml" ]; then
    DEST_DIR="/usr/share/hassio/homeassistant/custom_components/xiaomi_home/miot"
elif [ -f "/var/lib/homeassistant/homeassistant/configuration.yaml" ]; then
    DEST_DIR="/var/lib/homeassistant/homeassistant/custom_components/xiaomi_home/miot"
else
    echo "未找到 configuration.yaml，无法确定目标目录。"
    exit 1
fi

# 删除当前目录下的 miot_client.py（如果存在）
if [ -f "$FILENAME" ]; then
    echo "发现 $FILENAME，正在删除..."
    rm -f "$FILENAME"
fi

# 下载文件
echo "正在下载 $FILENAME ..."
wget -O "$FILENAME" "$URL"

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载失败，请检查URL或网络连接。"
    exit 1
fi

# 移动文件到目标目录
echo "正在移动 $FILENAME 到 $DEST_DIR ..."
mv "$FILENAME" "$DEST_DIR"

# 检查移动是否成功
if [ $? -eq 0 ]; then
    echo "文件已成功移动到 $DEST_DIR。"
else
    echo "移动失败，请检查目标目录权限或是否存在。"
    exit 1
fi
