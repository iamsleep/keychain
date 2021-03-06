#!/bin/bash

GETPASS=0
GETUSER=0

while [ "$1" != "" ]
do
	case $1
		in
		-p) GETPASS=1;
			shift 1;;
		-u) GETUSER=1;
			shift 1;;
		-s) SERVICE=$2;
			shift 2;;
		-v) verbose=1;
			shift 1;;
		*)  echo "Option [$1] not one of  [p, u, a, v]";    # Error (!)
			exit;;
	esac
done

SEC=`security find-generic-password -s $SERVICE -g 2>&1`

function getAttribute() {
	echo `echo "$SEC" | grep "$1" | cut -d \" -f 4`
}

# Get username (account)
if test $GETUSER -gt 0 ; then
	getAttribute "acct"
	exit 0
fi

# Get password
if test $GETPASS -gt 0 ; then
	echo `echo "$SEC" | grep "password" | cut -d \" -f 2`
	exit 0
fi
