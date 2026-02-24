#!/bin/bash
# 文件路径：/home/login/mcsmanager/daemon/data/InstanceData/549d3cd1917d463b868e2faf6db6c47d/start.sh

cd "$(dirname "$0")"

exec ./server \
  --port 25900 #端口设置 \
  --headless \
  --allow-lan \
  --mt-enabled \
  --max-players 6 \
  --max-spectators 5 \
  --community-servers-url auto \
  --http \
  --spectators 5 \
  --server-password "" #房间密码设置\
  --empty-timeout 5 \
  --replay-filename "UTCTIMESTAMP" \
  --replay-timeout 180 \
  --gameover-timeout 360 \
  --server-name "房间名字" \
  --game-mode "PAExpansion1:config" \
  --output-dir "实例安装目录/logs" \
  --server-data-dir "实例安装目录" \
  --enable-server-mods