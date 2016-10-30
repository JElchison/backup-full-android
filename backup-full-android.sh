#!/bin/bash

# backup-full-android.sh
#
# Bash script that performs a full backup of an Android phone (connected via USB)
#
# Version 1.0.1
#
# Copyright (C) 2016 Jonathan Elchison <JElchison@gmail.com>


# setup Bash environment
set -euf -o pipefail

###############################################################################
# functions
###############################################################################

# Prints script usage to stderr
# Arguments:
#   None
# Returns:
#   None
print_usage() {
    echo "Usage:    $0 <dest_dir> " >&2
    echo "Example:  $0 ~/backups/phone/" >&2
}


###############################################################################
# test dependencies
###############################################################################

echo "[+] Testing dependencies..." >&2

if [[ ! -x $(which mktemp) ]] ||
   [[ ! -x $(which adb) ]]; then
    echo "[-] ERROR: Required dependencies unmet. Please verify that the following are installed, executable, and in the PATH:  mktemp, adb" >&2
    exit 1
fi


###############################################################################
# validate arguments
###############################################################################

echo "[+] Validating arguments..." >&2

# require exactly 1 argument
if [[ $# -ne 1 ]]; then
    print_usage
    exit 1
fi

# setup variables for arguments
DEST_DIR=$1

echo "[+] Testing for existence of destination directory..." >&2
if [[ ! -d "$DEST_DIR" ]]; then
    echo "[-] ERROR: '$DEST_DIR' doesn't exist or isn't a directory" >&2
    exit 1
fi
echo "[*] Using destination directory = $DEST_DIR" >&2


###############################################################################
# perform backup
###############################################################################

TEMP_FILE=`mktemp`
echo "[*] Using temp file = $TEMP_FILE" >&2

echo "[+] Starting backup at $(date) ..." >&2

# timestamp marks when backup starts
DATE=`date +%Y%m%d%H%M%S`
OUT_FILE="$DEST_DIR/$DATE.ab"

time adb backup -f $TEMP_FILE -apk -obb -shared -all -system
echo "[+] Backup concluded at $(date)" >&2

echo "[+] Moving temp file to destination directory..." >&2
mv -v $TEMP_FILE "$OUT_FILE"

echo "[+] Setting output file as read-only ..." >&2
chmod -w "$OUT_FILE"

echo "[*] Output file exists at '$OUT_FILE'" >&2
ls -l "$OUT_FILE"

echo "[+] Success!" >&2
