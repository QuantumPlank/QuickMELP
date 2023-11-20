FROM ubuntu:20.04

LABEL maintainer="QuantumPlank@outlook.com"
LABEL version="0.2"
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
python3-dev \
rsync \
texinfo \
unzip \
wget \
xz-utils \
git \
pkg-config \
qemu-system-arm \
qemu-efi

# Create melp user
RUN adduser --disabled-password --gecos '' melp
RUN adduser melp sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy utility files/scripts to docker fs
COPY scripts/* /usr/

# Set default user
USER melp