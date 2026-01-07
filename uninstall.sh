#!/bin/bash

# 颜色定义
red='\033[0;31m'
green='\033[0;32m'
plain='\033[0m'

# 检查 root 权限
[[ $EUID -ne 0 ]] && echo -e "${red}错误: ${plain} 请使用 root 权限运行此脚本！\n" && exit 1

echo -e "${red}正在准备卸载 3x-ui 面板...${plain}"

# 1. 停止并禁用服务
echo -e "正在停止服务..."
if [[ -f /etc/alpine-release ]]; then
    rc-service x-ui stop 2>/dev/null
    rc-update del x-ui 2>/dev/null
    rm -f /etc/init.d/x-ui
else
    systemctl stop x-ui 2>/dev/null
    systemctl disable x-ui 2>/dev/null
    rm -f /etc/systemd/system/x-ui.service
    systemctl daemon-reload
fi

# 2. 删除面板文件和二进制文件
echo -e "正在删除安装文件..."
rm -rf /usr/local/x-ui
rm -f /usr/bin/x-ui

# 3. 删除日志文件
echo -e "正在清除日志..."
rm -rf /var/log/x-ui


rm -rf /root/cert
echo -e "已删除证书文件夹。"


echo -e "${green}3x-ui 卸载完成！${plain}"
