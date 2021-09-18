FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04 as base
MAINTAINER Raphael THIBIERGE

WORKDIR /app

# Install all packages required to build and install pyrit
RUN apt update && apt upgrade -y && apt install -y \
	git \
	python \
	python-dev \
	libssl-dev \
	libz-dev \
	libpcap-dev \
	libssl-dev \
	libz-dev \
	libpcap-dev \
	clang \
	python-clang \
	linux-headers-$(uname -r) \
	&& rm -rf /var/lib/apt/lists/*

# Clone Pyrit repository, build and install
RUN git clone https://github.com/JPaulMora/Pyrit.git Pyrit \
	&& cd Pyrit \
	&& sed -i "s/COMPILE_AESNI/COMPILE_AESNIX/" cpyrit/_cpyrit_cpu.c \
	&& python setup.py install \
	&& cd modules/cpyrit_cuda/ \
	&& python setup.py build \
	&& python setup.py install

# Add pyrit config
COPY config /root/.pyrit/config

# Default command
CMD ["pyrit", "benchmark"]
