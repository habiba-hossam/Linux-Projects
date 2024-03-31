#! /bin/sh

dir=$1
backupdir=$2
max_backups=$3



cd ./$backupdir
backupNO=$(ls -l | grep ^d | wc -l)

cd ..

cp -r directory-info-new.txt directory-info-last.txt
ls -lR $dir > ./directory-info-new.txt


if ! cmp -s directory-info-last.txt directory-info-new.txt
then

	cd ./$backupdir
	currentDate=$(date +%Y-%m-%d-%H-%S-%M)
	while [ "$backupNO" -ge "$max_backups" ]
	do
		rm -R $(ls -1t | tail -1)
		backupNO=`expr $backupNO - 1`
	done
	mkdir $currentDate
	backupNO=`expr $backupNO + 1`
	cd ..
	cp -r ./$dir/* ./$backupdir/$currentDate
fi
