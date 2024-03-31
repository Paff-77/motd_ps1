#!/bin/bash

# 清空 motd 文件
sudo truncate -s 0 /etc/motd

# 添加新的 motd 内容
sudo bash -c 'cat << "EOF" > /etc/motd

__________  _____  ______________________
\______   \/  _  \ \_   _____/\_   _____/
 |     ___/  /_\  \ |    __)   |    __)  
 |    |  /    |    \|     \    |     \   
 |____|  \____|__  /\___  /    \___  /   
                 \/     \/         \/    
EOF'

# 更改 PS1
PS1="\[\033[01;36m\]\$(date +%T) \[\033[01;31m\][\[\033[01;33m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h \[\033[01;35m\]\W\[\033[01;31m\]]\[\033[01;37m\]\\$ \[\033[00m\]"

# 将 PS1 写入 .bashrc 文件
echo "export PS1=\"$PS1\"" >> ~/.bashrc

# 刷新当前终端的 PS1
source ~/.bashrc

echo "motd and PS1 updated successfully."

read -rsn 1 -p "按任意键断开 SSH 连接重置..."
echo

# 断开 SSH 连接
kill -SIGHUP $PPID
