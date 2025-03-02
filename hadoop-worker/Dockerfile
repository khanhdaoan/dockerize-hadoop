FROM local/hadoop-base:3.3.6-java11

# Runtime healthcheck on datanode UI port
HEALTHCHECK --interval=90s --timeout=10s CMD curl -f hdfs://master:9864/ || exit 1
EXPOSE 9864

# Datanode mount point directory
RUN mkdir -p /mnt/dfs/data

COPY run.sh /run.sh
RUN chmod a+x /run.sh
CMD ["/run.sh"]
