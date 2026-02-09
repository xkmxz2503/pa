# 基于Debian 12 (bookworm) slim版本构建，amd64架构
FROM debian:bookworm-slim

# 完整的环境变量配置（覆盖SteamCMD所有运行需求）
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai 

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        # 保留你指定的精确版本
        wget=1.21-1+deb11u1 \
        ca-certificates=20210119 \
        lib32z1=1:1.2.11.dfsg-2+deb11u2 \
        # 基础依赖包（无版本限制）
        ffmpeg \
        libsm6 \
        libxext6 \
        # 替换 libcurl3-gnutls：Debian 11 中用 libcurl4-gnutls-dev 替代
        libcurl4-gnutls-dev \
    && rm -rf /var/lib/apt/lists/*
# 设置工作目录
WORKDIR /data

# 容器启动默认执行SteamCMD

