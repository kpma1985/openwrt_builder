FROM ubuntu:22.04

# Alle notwendigen Abhängigkeiten installieren
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
    perl \
    texinfo \
    autoconf \
    automake \
    libtool \
    pkg-config \
    xz-utils \
    bzip2 \
    g++ \
    libattr1-dev \
    libacl1-dev \
    bison \
    gperf \
    bc \
    && apt clean

# Environment-Variable für configure freischalten
ENV FORCE_UNSAFE_CONFIGURE=1

# Arbeitsverzeichnis
WORKDIR /opt

# OpenWrt Repository klonen
RUN git clone https://github.com/openwrt/openwrt.git

WORKDIR /opt/openwrt

# OpenWrt Version auswählen
RUN git checkout v23.05.3

# Feeds aktualisieren
RUN ./scripts/feeds update -a && ./scripts/feeds install -a

# Standard-Konfiguration laden
RUN make defconfig

# Tools stabil bauen
RUN make tools/install -j1 V=sc

# Toolchain stabil bauen
RUN make toolchain/install -j1 V=sc

# Pakete herunterladen
RUN make -j$(nproc) download V=sc || true

# OpenWrt komplett bauen
RUN make -j$(nproc) V=s

# Fertiges Arbeitsverzeichnis
WORKDIR /opt/openwrt/bin
