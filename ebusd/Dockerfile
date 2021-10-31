ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /

RUN \
    apk add --no-cache \
        build-base \
        argp-standalone \
        git \
        cmake \
        mosquitto-dev \
    && git clone https://github.com/john30/ebusd.git \
    && cd ebusd \
    && cmake . \
    && make \
    && make install

COPY rootfs /
