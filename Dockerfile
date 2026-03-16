FROM steamcmd/steamcmd:ubuntu-24

# 完整的环境变量配置（覆盖SteamCMD所有运行需求）
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai 

# Install PAT dependencies
RUN apt-get update && \
    apt-get install -y libsdl2-2.0-0 libgl1 libstdc++6 libcurl3-gnutls libuuid1 \
    && apt-get remove -y aptitude \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /data

RUN chmod -R 777 /data

COPY start.sh /data/
COPY start_help_zh.txt /data/

# 2. 给启动脚本赋予执行权限
RUN chmod +x start.sh

# 3. 指定容器启动时默认执行的脚本
CMD ["sh", "./start.sh"]