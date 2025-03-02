FROM local/hadoop-base:3.3.6-java11

# Runtime healthcheck on hdfs UI port
HEALTHCHECK --interval=90s --timeout=10s CMD curl -f hdfs://master:9870/ || exit 1
EXPOSE 9870

# Namenode mount point directory
RUN mkdir -p /mnt/dfs/name
RUN mkdir /mnt/host

# Namenode metadata port
#EXPOSE 9000

COPY run.sh /run.sh
RUN chmod a+x /run.sh
CMD ["/run.sh"]
