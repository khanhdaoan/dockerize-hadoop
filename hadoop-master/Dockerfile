FROM local/hadoop-base:latest

# Runtime healthcheck, using namenode UI port
HEALTHCHECK --interval=90s --timeout=10s CMD curl -f hdfs://master:9870/ || exit 1

# Create mount point for namenode
RUN mkdir -p /mnt/dfs/name

# Expose namenode UI and metadata port
EXPOSE 9870 9000

COPY run.sh /run.sh
RUN chmod a+x /run.sh
CMD ["/run.sh"]
