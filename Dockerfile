FROM steamcmd/steamcmd:ubuntu-24

# 完整的环境变量配置（覆盖SteamCMD所有运行需求）
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai 

# Install PAT dependencies
RUN apt-get update && \
    apt-get install -y libsdl2-2.0-0 libgl1 libstdc++6 libcurl3-gnutls libuuid1 libidn12 libgcrypt20 librtmp1 \
    && apt-get remove -y aptitude \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/lib/x86_64-linux-gnu/libidn.so.12 /usr/lib/x86_64-linux-gnu/libidn.so.11 \
    && ln -s /usr/lib/x86_64-linux-gnu/libgcrypt.so.20 /usr/lib/x86_64-linux-gnu/libgcrypt.so.11 \
    && ln -s /usr/lib/x86_64-linux-gnu/librtmp.so.1 /usr/lib/x86_64-linux-gnu/librtmp.so.0

# 设置工作目录
WORKDIR /data

# 复制文件 + 设置权限（合并操作，避免冗余）
COPY start.sh /script/
COPY ./start_help/ /script/help/

RUN chmod -R 755 /script && \
    chmod +x /script/start.sh
ENTRYPOINT []
# 3. 指定容器启动时默认执行的脚本
CMD ["sh", "/script/start.sh"]