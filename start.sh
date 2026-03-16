#!/bin/bash

cp /script/server_help_zh.txt /data/
cd /data/gamefiles
./server --help > /data/server_help.txt

# 1. 初始化空数组
SERVER_ARGS=""

# 2. 逐个添加参数（注意：不需要额外加引号，数组会自动处理）

# 端口 (默认: 20545)
SERVER_ARGS="$SERVER_ARGS --port ${SERVER_PORT:-20545}"

# 无头模式 (默认: 启用)
if [ "${HEADLESS:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --headless"
fi

# 允许局域网 (默认: 启用)
if [ "${ALLOW_LAN:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --allow-lan"
fi

# 多线程 (默认: 启用)
if [ "${MT_ENABLED:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --mt-enabled"
fi

# 最大玩家数 (默认: 6)
SERVER_ARGS="$SERVER_ARGS --max-players ${MAX_PLAYERS:-6}"

# 最大观众数 (默认: 5)
SERVER_ARGS="$SERVER_ARGS --max-spectators ${MAX_SPECTATORS:-5}"

# 社区服务器URL (默认: auto)
SERVER_ARGS="$SERVER_ARGS --community-servers-url ${COMMUNITY_SERVERS_URL:-auto}"

# HTTP服务器 (默认: 启用)
if [ "${HTTP_ENABLED:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --http"
fi

# 服务器密码 (默认: 空)
# 注意：这里直接拼接，不需要额外引号
SERVER_ARGS="$SERVER_ARGS --server-password ${SERVER_PASSWORD:-}"

# 回放文件名 (默认: UTCTIMESTAMP)
SERVER_ARGS="$SERVER_ARGS --replay-filename ${REPLAY_FILENAME:-UTCTIMESTAMP}"

# 回放超时 (默认: 180)
SERVER_ARGS="$SERVER_ARGS --replay-timeout ${REPLAY_TIMEOUT:-180}"

# 游戏结束超时 (默认: 360)
SERVER_ARGS="$SERVER_ARGS --gameover-timeout ${GAMEOVER_TIMEOUT:-360}"

# 服务器名称 (默认: A Dockerised PA:T Server)
# 关键：这里直接拼接变量，数组会处理空格
SERVER_ARGS="$SERVER_ARGS --server-name ${SERVER_NAME:-A Dockerised PA:T Server}"

# 游戏模式 (默认: PAExpansion1:lobby)
SERVER_ARGS="$SERVER_ARGS --game-mode ${GAME_MODE:-PAExpansion1:lobby}"

# 输出目录 (默认: /data/logs)
SERVER_ARGS="$SERVER_ARGS --output-dir ${OUTPUT_DIR:-/data/logs}"

# 3. 打印调试信息（使用数组展开形式）
echo "Starting server with: ./server $SERVER_ARGS"

# 4. 执行服务器（关键：使用数组展开）
exec ./server $SERVER_ARGS
