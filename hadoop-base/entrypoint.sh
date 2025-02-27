#!/bin/bash

# Function: mvb
# A wrapper for mv that backup instead of overwriting file
# Usage: mvb source destination
mvb() {
	# Check for 2 arguments
	if [ "$#" -ne 2 ]; then
		echo "Usage: mvb source destination"
		return 1
	fi
	
	local src="$1"
	local dst="$2"
	
	# Check if source exists
	if [ ! -e "$src" ]; then
		echo "Error: '$src' does not exist"
		return 1
	fi

	# Setup local var
	local src_basename=$(basename "$src")
	local backup="${dst}.bak"

	# If destination is a directory, append filename
	if [ -d "$dst" ]; then
		dst="${dst%/}/${src_basename}"
	fi
	
	# Check if destination file exists
	if [ -f "$dst" ]; then
		if [ -e "$backup" ]; then
			# If backup already exists, do nothing
			echo "Backup already exists"
		else
			# Create backup
			cp -p "$dst" "$backup"
			echo "Backed up '$dst' to '$backup'"
		fi
	fi
	
	# Move
	mv "$src" "$dst"
	echo "Moved '$src' to '$dst'"
}

# Initialization code
if [ ! -f "/.initialized" ]; then

	# Create exclusion file
	touch ${HADOOP_CONF_DIR}/excludes.txt

# Set initialization flag
  touch "/.initialized"
  echo "Container initialized" >> /.initialized
fi

# Execute the command passed to docker run
exec "$@"
