ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /

RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base \
        argp-standalone \
        git \
        cmake \
    # && apk add --no-cache \
    #     mosquitto-dev \
    && git clone https://github.com/john30/ebusd.git \
    && cd ebusd \
    && cmake \
        -DCMAKE_CXX_FLAGS="-static-libgcc -static-libstdc++" \
        . \
    && make \
    && make install \
    && cd .. \
    && apk del --no-cache --purge .build-dependencies \
    && rm -rf ebusd

COPY rootfs /
