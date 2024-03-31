dir="source"
backupdir="dest3"
interval_secs="2"
max_backups="2"


all: check call_backup


check:
	@ if [ -d "$(backupdir)" ]; then\
		continue;\
	else\
		mkdir $(backupdir);\
	fi 

	
call_backup:
	@ ./backupd.sh "$(dir)" "$(backupdir)" "$(interval_secs)" "$(max_backups)"
