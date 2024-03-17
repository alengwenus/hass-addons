ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /lcnpchk

ARG BUILD_ARCH
RUN \
    set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && if [[ "armv7 armhf aarch64" = *"$BUILD_ARCH"* ]]; \
      then \
        apt-get update \
        && apt-get install -y --no-install-recommends \
          build-essential \
          git \
        && git clone --depth 1 https://github.com/WiringPi/WiringPi /usr/src/wiringpi \
        && cd /usr/src/wiringpi/wiringPi \
        && make \
        && make install \
        && cd ../devLib \
        && make \
        && make install \
        && cd ../gpio \
        && make \
        && make install \
        && apt-get purge -y --auto-remove \
          build-essential \
          git \
        && rm -rf \
          /var/lib/apt/lists/* \
          /usr/src/wiringpi; \
      fi


# Install LCN-PCHK
RUN \
    set -x \
    && cd /tmp \
    && if [[ "armv7 armhf aarch64" = *"$BUILD_ARCH"* ]]; \
      then \
        curl -q -k -J -L -o /tmp/lcnpchk322_arm.tar.gz.zip https://www.lcn.eu/?wpdmdl=8088 \
        && unzip lcnpchk322_arm.tar.gz.zip \
        && tar -xf lcnpchk322_RaspBianJessy_dynamic.tar.gz -C /lcnpchk; \
      else \
        curl -q -k -J -L -o /tmp/lcnpchk322_amd64.tar.gz.zip https://www.lcn.eu/?wpdmdl=8086 \
        && unzip lcnpchk322_amd64.tar.gz.zip \
        && tar -xf lcnpchk322_debian64bit_dynamic.tar.gz -C /lcnpchk; \
      fi \
    && rm -rf /tmp/* \
    && mkdir -p /lcnpchk/log \
    && chmod a+x /lcnpchk/lcnpchk \
    && chown root:root /lcnpchk/lcnpchk \
    && sed -i 's/\/root/\/data/' /etc/passwd

COPY rootfs /

