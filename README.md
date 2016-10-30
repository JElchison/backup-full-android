# backup-full-android
Bash script that performs a full backup of an Android phone (connected via USB).  (See [Limitations](#limitations) below.)

Based on [Ryan Conrad](https://android.stackexchange.com/users/1951/ryan-conrad)'s answer at http://android.stackexchange.com/a/28315/91564


## Features

* Performs a full backup via Android's [adb](https://developer.android.com/tools/help/adb.html) tool
* Writes resultant backup file named (with current timestamp) in directory of your choosing
* Resultant backup file is encrypted using a user-provided password
* Resultant backup file is set with read-only permissions
* Displays "Success!" upon successful completion
* Runs on any OS having a Bash environment


## Usage

```
./backup-full-android.sh <dest_dir> 
```
Example:
```
./backup-full-android.sh ~/backups/phone/
```

If you don't see the "Success!" message at the end, then something went wrong.

### Example usage
On Ubuntu:
```
user@computer:~$ ./backup-full-android.sh /mnt/raid/bak/phones/MotoX
[+] Testing dependencies...
[+] Validating arguments...
[+] Testing for existence of destination directory...
[*] Using destination directory = /mnt/raid/bak/phones/MotoX
[*] Using temp file = /tmp/tmp.DS7agv6HzR
[+] Starting backup at Sat Mar  5 12:56:20 EST 2016 ...
* daemon not running. starting it now on port 5037 *
* daemon started successfully *
Now unlock your device and confirm the backup operation.

real    23m3.877s
user    0m0.226s
sys     0m14.507s
[+] Backup concluded at Sat Mar  5 13:19:24 EST 2016
[+] Moving temp file to destination directory...
‘/tmp/tmp.DS7agv6HzR’ -> ‘/mnt/raid/bak/phones/MotoX/20160305125620.ab’
removed ‘/tmp/tmp.DS7agv6HzR’
[+] Setting output file as read-only ...
[*] Output file exists at '/mnt/raid/bak/phones/MotoX/20160305125620.ab'
-r--r----- 1 user user 3668624773 Mar  5 13:19 /mnt/raid/bak/phones/MotoX/20160305125620.ab
[+] Success!
```


## Requirements

* Phone running Android 4.0+, connected to your computer via USB


## Environment

* Any OS having a Bash environment
* The following tools must be installed, executable, and in the PATH:
    * mktemp
    * adb
* Setup USB debugging on your phone.  For instructions, please see http://android.stackexchange.com/a/28315/91564


## Prerequisites

To install necessary prerequisites on Ubuntu:

    sudo apt-get install adb android-tools-adb android-tools-adbd


## Restoring

Please see instructions at http://android.stackexchange.com/a/28315/91564


## Limitations

* This script is simply a wrapper for [adb](https://developer.android.com/tools/help/adb.html), so it will carry with it all of adb's limitations.
* This script will not backup and restore:
    * Contacts
    * SMS
    * Calendar information
    * Ringtone and notification sounds
    * Activated input languages (i.e. keyboard layouts)
    * Owner name (owner name set in first boot wizard is kept instead)


## Tips

* If you find that you can't click the button that says "Back up my data", check out https://android.stackexchange.com/questions/115865/button-to-allow-adb-backup-not-working


## Disclaimer

No backup tool is perfect.  This tool has been helpful for me.  If used properly, I hope it's helpful for you.  Unfortunately, I cannot provide any guarantees as to the completeness or soundness of this script with your phone, on your computer, in your environment.  Use at your own risk.

Please, always [test your backups](http://searchdatabackup.techtarget.com/tip/Backup-and-recovery-basics-Testing-your-backups)!
