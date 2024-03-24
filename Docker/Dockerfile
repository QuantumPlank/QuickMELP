FROM ubuntu:20.04

LABEL maintainer="QuantumPlank@outlook.com"
LABEL version="0.3"
LABEL description="This Docker Image is intended to be used as a build environment for MELP"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get upgrade -y

# Install Host packages
RUN apt-get install -y \
    autoconf \
    automake \
    bison \
    bc \
    bzip2 \
    cmake \
    flex \
    g++ \
    gawk \
    gcc \
    gettext \
    git \
    gperf \
    help2man \
    libncurses5-dev \
    libstdc++6 \
    libtool \
    libtool-bin \
    make \
    patch \
    python3 \
    python3-dev \
    rsync \
    texinfo \
    unzip \
    wget \
    xz-utils \
    git \
    pkg-config \
    qemu-system-arm \
    qemu-efi \
    device-tree-compiler \
    u-boot-tools \
    pip \
    subversion

RUN apt-get install -y \
    build-essential \
    dfu-util \
    efitools \
    gdisk \
    graphviz \
    imagemagick \
    liblz4-tool \
    libgnutls28-dev \
    libguestfs-tools \
    libpython3-dev \
    libsdl2-dev \
    libssl-dev \
    lz4 \
    lzma \
    lzma-alone \
    openssl \
    python3-asteval \
    python3-coverage \
    python3-filelock \
    python3-pkg-resources \
    python3-pycryptodome \
    python3-pyelftools \
    python3-pytest \
    python3-pytest-xdist \
    python3-sphinxcontrib.apidoc \
    python3-sphinx-rtd-theme \
    python3-subunit \
    python3-testtools \
    python3-virtualenv \
    swig \
    uuid-dev

# Create melp user
RUN adduser --disabled-password --gecos '' melp
RUN adduser melp sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set default user
USER melp