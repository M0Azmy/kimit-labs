#!/bin/bash

# this script will backup to remote server
# modify variables as needed
# using rsync command


# Variables
Source_Dir="/root/onlineTests/kimitCourse/kimit-labs/"
Log_File="log.log"
Remote_Host="hol2@192.168.37.127"
Remote_Dir="/home/hol2/remoteBackups/"

# Function 

perform_backup() {
	rsync -avz "$Source_Dir" "$Remote_Host":"$Remote_Dir" >> "$Log_File" 2>&1
	if [ $? -eq 0 ];
	then
		echo " Backup success !! : $(date) " >>  "$Log_File"
		echo " *****************************************************"
		echo "      ******************************************      "
		echo " "
	else
		echo " Backup FAILURE !!!! : $(date) " >> "$Log_File"
		echo " ****************************************************** "
		echo -e "       *************************************     \n      "
	fi
}

# Run the backup

perform_backup
