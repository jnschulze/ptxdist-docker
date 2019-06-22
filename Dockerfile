FROM debian:stable-slim

ARG PTXDIST_VERSION=2019.06.0

RUN apt-get update && apt-get install -y -qq \
	gcc \
	g++ \
	autoconf \
	automake \
	make \
	python2.7 \
	python2.7-dev \
	flex \
	bison \
	gawk \
	gettext \
	texinfo \
	git \
	wget \
	pkg-config \
	ncurses-dev && \
	apt-get clean

RUN mkdir -p /usr/src && \
	cd /usr/src && \
	git clone git://git.pengutronix.de/ptxdist && \
	cd ptxdist && \
	git checkout ptxdist-$PTXDIST_VERSION -b tmp && \
	./autogen.sh && \
	./configure && \
	make && \
	make install && \
	rm -rf /usr/src

ENTRYPOINT ["/usr/local/bin/ptxdist"]
