FROM ubuntu:24.04

# Base image for Hadoop hdfs, run in root to avoid issue with mount volume

WORKDIR /opt

# Install necessary packages, no prompt, no recommend
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		openjdk-11-jdk-headless \
		openssh-server \
		openssh-client \
		net-tools \
		curl \
		gnupg \
		libsnappy-dev \
	&& rm -rf /var/lib/apt/lists/*

# Java env
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

# Install and verify hadoop. Initialize variables.
ENV HADOOP_VERSION=hadoop-3.3.6
ENV HADOOP_URL=https://www.apache.org/dist/hadoop/common/${HADOOP_VERSION}/${HADOOP_VERSION}.tar.gz
ENV HADOOP_HOME=/opt/${HADOOP_VERSION}
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS
RUN set -x \
	&& curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
	&& curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
	&& gpg --verify /tmp/hadoop.tar.gz.asc \
	&& tar -xvf /tmp/hadoop.tar.gz -C ./ \
	&& rm /tmp/hadoop.tar.gz*   

# Bind to all interface if needed, avoid any address and hostname issue
# ENV MULTIHOMED_NETWORK=1

# Add to paths
ENV PATH=${HADOOP_HOME}/bin/:${PATH}
ENV PATH=${HADOOP_HOME}/sbin/:${PATH}

# Copy config files, edit list as needed.
COPY core-site.xml hdfs-site.xml ${HADOOP_CONF_DIR}}

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
