# Bash-Backup
#  Directory Backup

This project make a continuously and automatically directory backup.

## Installation and Prepreqisits
- Install make on Ubunto by the following bash commands:
$ sudo apt update
$ make -version
$ sudo apt install make
$ ls /usr/bin/make
- Download the program zip file.
- Make your own source and destination folders (or you can use the default ones).
- change the mode of the backupd.sh to executable mode by:
    
    $ chmod 777 backupd.sh
    
- No prepreqisits needed for this program.

## Code Description:
* The Makefile checks for the existance of the destination directory and if it was not found, create one.
* Then the Makefile call and pass the arguments to backupd.sh
* First the program checks for the validation of its parameters.
* Then the program checks if the destination file is full with the max_backups or not.
* If it is full then it removes the oldest backup. It repeats these steps until there is a space for the next backup.
* If the destination was not full, the program hold the first backup of the source file in a directory named with the current date. Then the current state of the source file is written into the directory-info-old.txt.
* Then the program enter a infinite while loop to continuously backup files. It starts with a sleep command to wait a given interval of time.
* Then the state of the source file is written into the directory-info-new.txt. and is compared with the old state written into the directory-info-old.txt. 
* If they were the same the program continue to the next loop.
* If they are different which mean that a change has occure in the source file, then the check for a max_backups will take place again then backup.


## Content
6794-lab2 is the main folder of the program. It contain:

* backupd.sh:  Is a bash scipt include the source code of the program. It is invoked by the Makefile.
* Makefile: It have two targets:
    
    check: to check the existance of the destination directory and if it was not found it creat one.
    
    call_backup: to call the bash file and pass the parameters to it.
* directory-info-old.txt: Is a text file to hold the last state of the source file after the last backup.
* directory-info-new.txt: Is a text file to hold the state of the source file after the modification and before the backup.



## Running and Usage

First you have to enter the parameters then call the make command.  For Example:
$ make dir="Source" backupdir="dest" interval_secs="5" max_backups="2" 

where.. "dir" is source file,  "backupdir" is destination file  "interval_secs" is the time waited between the backups  "max_backups" is the maximam number of backups in the destination directory.
## Validation
This program handle some errors as:
* If the Source File was not found.
* If the user entered parameters less than needed.
* If the user entered non-integer values for max_backups and interval_secs.
The program handle these errors by echoing an error message then exit.

P.S ..if the user entered an non-existance destination directory, the program make one with name passed to the program as a parameter.

## Cron Backup
Steps for installation:
- Write in the terminal 
    
    $ crontab -e 
    
- Choose option 1. /bin/nano
- Write at the end of the opened window:
    
    * * * * * (cd <path of the program folder> && ./backup_cron.sh <source file name> <destination file name> <max_backups>)
    
- Hit ctrl+o >> enter >> ctrl+x

## Scheduling
If you need to run this backup every 3rd Friday of the month at 12:31 am:

Include this line in instalation the crontab
31 00 15-21 * 5 (cd <path of directory> &&  ./backup_cron.sh <source file name> <destination file name> <max_backups>)


 ## Support
I am pleased to hear from you, if you faced any issues will using this program do not hesitate to contact me.
email: habibabakr5@gmail.com
