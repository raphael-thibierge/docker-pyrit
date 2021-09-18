ARG CUDA_VERSION=11.4.1

FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu18.04 as base
MAINTAINER Raphael THIBIERGE

WORKDIR /app

# Install all packages required to build and install pyrit
RUN apt update && apt upgrade -y && apt install -y \
	git \
	python \
	python-dev \
	python-pip \
	libssl-dev \
	zlib1g-dev \
	libpcap-dev \
	linux-headers-generic \
	clang \
	&& rm -rf /var/lib/apt/lists/* \
	&& pip install --no-cache sqlalchemy


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
