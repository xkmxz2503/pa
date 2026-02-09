# 基于Debian 12 (bookworm) slim版本构建，amd64架构
FROM debian:bookworm-slim

# 完整的环境变量配置（覆盖SteamCMD所有运行需求）
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Shanghai 

RUN dpkg --add-architecture i386 \
    && echo "deb http://deb.debian.org/debian bullseye main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://deb.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/debian-security bullseye-security main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    # 安装必要工具，用于查找可用版本
    && apt-get install -y --no-install-recommends aptitude \
    # 尝试安装指定版本，失败则自动降级到可用版本
    && aptitude install -y \
        wget=1.21-1+deb11u1 || aptitude install -y wget \
        ca-certificates=20210119 || aptitude install -y ca-certificates \
        lib32z1=1:1.2.11.dfsg-2+deb11u2:i386 || aptitude install -y lib32z1:i386 \
        ffmpeg \
        libsm6 \
        libxext6 \
        libcurl4-gnutls-dev \
    # 清理缓存和多余工具，减小镜像体积
    && apt-get remove -y aptitude \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
# 设置工作目录
WORKDIR /data

# 容器启动默认执行SteamCMD

