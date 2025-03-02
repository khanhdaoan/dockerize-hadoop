#!/bin/bash

if [ ! -d "/mnt/dfs/name"]; then
	echo "Namenode directory missing!"
	exit 2
fi

if [ ! -d "/mnt/host"]; then
	echo "Host mount point missing!"
	exit 2
fi

# Master node initialization
if [ ! -f "/.initialized-master" ]; then
	# Format namenode
	rm -r /mnt/dfs/name/
	hdfs namenode -format

	# Set initialization flag
	touch "/.initialized-master"
	echo "Namenode directory formatted." >> /.initialized-master
fi

# Start namenode
exec hdfs namenode
