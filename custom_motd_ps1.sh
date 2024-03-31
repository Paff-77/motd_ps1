#!/bin/bash

# 检测是否安装了 neofetch
if ! command -v neofetch &> /dev/null
then
    # 如果没有安装，则自动安装 neofetch
    echo "neofetch 未安装，正在安装..."
    sudo apt update
    sudo apt install neofetch -y
fi

# 清空 motd 文件
sudo truncate -s 0 /etc/motd

# 删除 /etc/update-motd.d/ 目录下的所有脚本文件
sudo rm -f /etc/update-motd.d/*

# 添加新的 motd 内容
neofetch > /etc/motd

# 修改 /etc/pam.d/login 文件，禁用 "Last login" 行的显示
sudo sed -i '/^session    optional     pam_lastlog.so/d' /etc/pam.d/login

# 更改 PS1
PS1="\[\033[01;36m\]\$(date +%T) \[\033[01;31m\][\[\033[01;33m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h \[\033[01;35m\]\W\[\033[01;31m\]]\[\033[01;37m\]\\$ \[\033[00m\]"

# 将 PS1 写入 .bashrc 文件
echo "export PS1=\"$PS1\"" >> ~/.bashrc

# 刷新当前终端的 PS1
source ~/.bashrc

echo "motd, PS1, and 'Last login' message updated successfully."

read -rsn 1 -p "按任意键断开 SSH 连接重置..."
echo

# 断开 SSH 连接
kill -SIGHUP $PPID
