#!/bin/bash

# Base entrypoint, create exclusion file

# Initialization code
if [ ! -f "/.initialized" ]; then
	# Create exclusion file
	touch ${HADOOP_CONF_DIR}/excludes.txt

	# Set initialization flag
	touch "/.initialized"
	echo "Hadoop exclusion file created." >> /.initialized
fi

# Execute the command passed to docker run
exec "$@"
