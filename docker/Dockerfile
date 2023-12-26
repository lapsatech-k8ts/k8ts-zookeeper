FROM ubuntu:16.04 

RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless \
                          netcat \
    && rm -rf /var/lib/apt/lists/* \
    && true

ENV PATH=/opt/zookeeper/bin:${PATH} \
    ZK_VERSION=3.9.1

RUN set -x \
    && DIST_NAME=apache-zookeeper-$ZK_VERSION-bin \
    \
    && apt-get update \
    && apt-get install -y curl \
    && curl -f -o DIST.tar.gz \
            "https://downloads.apache.org/zookeeper/zookeeper-$ZK_VERSION/$DIST_NAME.tar.gz" \
    && tar -xzf DIST.tar.gz -C /opt \
    && rm -rfv DIST.tar.gz \
    && ln -svT /opt/$DIST_NAME /opt/zookeeper \
    && chmod -v +x /opt/zookeeper/bin/* \
    && apt-get autoremove -y curl \
    && rm -rf /var/lib/apt/lists/* \
    \
    && which zkCli.sh \
    && which zkServer.sh \
    && true

COPY ROOT /

RUN set -x \
    && chmod -v +x /usr/local/bin/* \
    && which zookeeper-entrypoint.sh \
    && which zookeeper-metrics.sh \
    && which zookeeper-ready.sh \
    && true

ENTRYPOINT zookeeper-entrypoint.sh
