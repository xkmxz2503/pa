#!/bin/bash

cd /data/gamefiles
./server --help > /data/server_help.txt

# 初始化参数数组
SERVER_ARGS=""

# 1. 端口 (默认: 20545)
SERVER_ARGS="$SERVER_ARGS --port ${SERVER_PORT:-20545}"

# 2. 无头模式 (默认: 启用，设为 "false" 禁用)
if [ "${HEADLESS:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --headless"
fi

# 3. 允许局域网 (默认: 启用，设为 "false" 禁用)
if [ "${ALLOW_LAN:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --allow-lan"
fi

# 4. 多线程启用 (默认: 启用，设为 "false" 禁用)
if [ "${MT_ENABLED:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --mt-enabled"
fi

# 5. 最大玩家数 (默认: 6)
SERVER_ARGS="$SERVER_ARGS --max-players ${MAX_PLAYERS:-6}"

# 6. 最大观众数 (默认: 5)
SERVER_ARGS="$SERVER_ARGS --max-spectators ${MAX_SPECTATORS:-5}"

# 7. 社区服务器URL (默认: auto)
SERVER_ARGS="$SERVER_ARGS --community-servers-url ${COMMUNITY_SERVERS_URL:-auto}"

# 8. HTTP服务器 (默认: 启用，设为 "false" 禁用)
if [ "${HTTP_ENABLED:-true}" != "false" ]; then
    SERVER_ARGS="$SERVER_ARGS --http"
fi

# 9. 服务器密码 (默认: 空)
# 注意：如果密码包含特殊字符，在Docker中传递环境变量时需注意转义
SERVER_ARGS="$SERVER_ARGS --server-password \"${SERVER_PASSWORD:-}\""

# 10. 回放文件名 (默认: UTCTIMESTAMP)
SERVER_ARGS="$SERVER_ARGS --replay-filename ${REPLAY_FILENAME:-UTCTIMESTAMP}"

# 11. 回放超时 (默认: 180)
SERVER_ARGS="$SERVER_ARGS --replay-timeout ${REPLAY_TIMEOUT:-180}"

# 12. 游戏结束超时 (默认: 360)
SERVER_ARGS="$SERVER_ARGS --gameover-timeout ${GAMEOVER_TIMEOUT:-360}"

# 13. 服务器名称 (默认: a Game Hall)
SERVER_ARGS="$SERVER_ARGS --server-name \"${SERVER_NAME:-a Game Hall}\""

# 14. 游戏模式 (默认: PAExpansion1:lobby)
SERVER_ARGS="$SERVER_ARGS --game-mode \"${GAME_MODE:-PAExpansion1:lobby}\""

# 15. 输出目录 (默认: /data/logs)
SERVER_ARGS="$SERVER_ARGS --output-dir ${OUTPUT_DIR:-/data/logs}"

# 打印启动命令（便于调试）
echo "Starting server with: ./server $SERVER_ARGS"

# 执行服务器
exec ./server $SERVER_ARGS

  

  