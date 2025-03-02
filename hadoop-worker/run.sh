#!/bin/bash

if [ ! -d "/mnt/dfs/data" ]; then
	echo "Datanode directory missing!"
	exit 2
fi

if [ ! -f "/.initialized-worker" ]; then
	# Format namenode
	rm -r /mnt/dfs/data/

	# Set initialization flag
	touch "/.initialized-worker"
	echo "Datanode directory initialized." >> /.initialized-worker
fi

# Start namenode
exec hdfs datanode
