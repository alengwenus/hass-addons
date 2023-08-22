ARG BUILD_FROM
FROM $BUILD_FROM

ARG VERSION=2.3.0

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /sae

ARG BUILD_ARCH

RUN \
    set -x \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        sudo procps wget gettext-base nginx openjdk-11-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /opt/sae -m -s /bin/bash sae \
    && usermod -a -G sudo sae \
    && wget https://github.com/camueller/SmartApplianceEnabler/raw/master/run/smartapplianceenabler -P /opt/sae \
    && chmod 755 /opt/sae/smartapplianceenabler \
    && wget https://github.com/camueller/SmartApplianceEnabler/raw/master/run/etc/default/smartapplianceenabler -P /etc/default \
    && chmod 644 /etc/default/smartapplianceenabler \
    && wget https://github.com/camueller/SmartApplianceEnabler/raw/master/run/logback-spring.xml -P /opt/sae \
    && chmod 644 /opt/sae/logback-spring.xml \    
    && wget https://github.com/camueller/SmartApplianceEnabler/releases/download/${VERSION}/SmartApplianceEnabler-${VERSION}.war -P /opt/sae \
    && chown -R sae:sae /opt/sae

COPY rootfs /
COPY *.xml /opt/sae/
