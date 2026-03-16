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

# 复制文件 + 设置权限（合并操作，避免冗余）
COPY start.sh start_help_zh.txt /data/script/
RUN chmod -R 755 /data && \
    chmod +x /data/script/start.sh

# 3. 指定容器启动时默认执行的脚本
CMD ["sh", "/data/script/start.sh"]