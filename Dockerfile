# Stage 1: OpenWrt Build Environment
FROM debian:bookworm AS builder

RUN apt update && apt install -y \
    build-essential \
    ccache \
    libncurses5-dev \
    zlib1g-dev \
    gawk \
    git \
    subversion \
    flex \
    gettext \
    libssl-dev \
    python3 \
    python3-distutils \
    file \
    wget \
    unzip \
    curl \
    rsync \
    time \
    && apt clean

WORKDIR /opt
RUN git clone https://github.com/openwrt/openwrt.git

WORKDIR /opt/openwrt
RUN git checkout v23.05.3

RUN ./scripts/feeds update -a && ./scripts/feeds install -a

RUN make defconfig

RUN make -j$(nproc) download
RUN make -j$(nproc)

# Stage 2: Export Stage
FROM debian:bookworm AS export

COPY --from=builder /opt/openwrt/bin /build

WORKDIR /build

CMD ["bash"]
