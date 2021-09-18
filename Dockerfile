FROM nvidia/cuda:11.4.2-cudnn8-devel-ubuntu20.04 as base
MAINTAINER Raphael THIBIERGE

WORKDIR /app

# Install all packages required to build and install pyrit
RUN apt update && apt upgrade -y && apt install -y \
	git \
	curl \
	vim \
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

# Install sqlalchemy to use slqite with pyrit
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py \
	&& python get-pip.py \
	&& rm get-pip.py \
	&& pip install sqlalchemy


# Clone Pyrit repository, build and install
RUN git clone https://github.com/JPaulMora/Pyrit.git Pyrit \
	&& cd Pyrit \
	&& sed -i "s/COMPILE_AESNI/COMPILE_AESNIX/" cpyrit/_cpyrit_cpu.c \
	&& python setup.py install \
	&& cd modules/cpyrit_cuda/ \
	&& python setup.py build \
	&& python setup.py install \
	&& cd ../../../ && rm -rf Pyrit

# Add pyrit config for root user (not recommanded)
COPY config /root/.pyrit/config
# Add pyrit config for any user
COPY config /.pyrit/config


# Set pyrit as defautl entrypoint and display help menu by default
ENTRYPOINT ["/usr/local/bin/pyrit"]
CMD ["-h"]
