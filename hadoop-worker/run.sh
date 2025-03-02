#!/bin/bash

if [ ! -d "/mnt/dfs/data" ]; then
	echo "Datanode directory missing!"
	exit 2
fi

# Start namenode
exec hdfs datanode
