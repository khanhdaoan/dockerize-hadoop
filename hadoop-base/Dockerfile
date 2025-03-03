FROM ubuntu:24.04

# Base image for Hadoop hdfs, run in root to avoid issue with mount volume

WORKDIR /root

# Install necessary packages, no prompt, no recommend
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		openjdk-11-jdk-headless \
		netcat-openbsd \
		net-tools \
		curl \
		aria2 \
		gnupg \
		libsnappy-dev \
	&& rm -rf /var/lib/apt/lists/*

# Java env
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Install and verify hadoop. Initialize variables.
ENV HADOOP_VERSION=hadoop-3.3.6
ENV HADOOP_URL=https://www.apache.org/dist/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz
ENV HADOOP_HOME=/root/${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop

RUN aria2c -x 16 -s 16 https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN set -x && \
gpg --import KEYS && \
aria2c -x 16 -s 16 -d /tmp -o hadoop.tar.gz "${HADOOP_URL}" && \
aria2c -x 4 -s 4 -d /tmp -o hadoop.tar.gz.asc "${HADOOP_URL}.asc" && \
gpg --verify /tmp/hadoop.tar.gz.asc && \
tar -xvf /tmp/hadoop.tar.gz -C ./ && \
rm /tmp/hadoop.tar.gz* KEYS
# Add to paths
ENV PATH=${HADOOP_HOME}/bin:${PATH}

# Copy config files, edit list as needed.
COPY core-site.xml hdfs-site.xml ${HADOOP_CONF_DIR}/

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
