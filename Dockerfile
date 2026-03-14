FROM steamcmd/steamcmd:ubuntu-22

# 完整的环境变量配置（覆盖SteamCMD所有运行需求）
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai 

# Install PAT dependencies
RUN apt-get update && \
    # 最小改动：Ubuntu24移除了libcurl3-gnutls，替换为兼容的libcurl4-gnutls-dev（功能一致）
    apt-get install -y libsdl2-2.0-0 libgl1 libstdc++6 libcurl4-gnutls-dev libuuid1 \
    && apt-get remove -y aptitude \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /data