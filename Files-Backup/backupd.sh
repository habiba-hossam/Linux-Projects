#! /bin/sh

dir=$1
backupdir=$2
interval_secs=$3
max_backups=$4
no=$#

if [ $# -lt 4 ]
then
	echo "Not enough parameters"
	exit
fi


if [ -d $dir ]
then
	
	continue
else
	echo "Source Not found"
	exit
fi


case $interval_secs in 
	''|*[!0-9]*)
	echo "Interval time must be an integer"
	exit ;;
	*) continue;;
esac

 case $max_backups in 
	''|*[!0-9]*)
	echo "max backups must be an integer"
	exit ;;
	*) continue;;
esac


ls -lR $dir > ./directory-info-last.txt

cd ./$backupdir
currentDate=$(date +%Y-%m-%d-%H-%S-%M)


backupNO=$(ls -l | grep ^d | wc -l)

# echo "backupNO= $backupNO"
while [ "$backupNO" -ge "$max_backups" ]
do
	# echo "out of range"
	rm -R $(ls -1t | tail -1)
	backupNO=`expr $backupNO - 1`
done
mkdir $currentDate
backupNO=`expr $backupNO + 1`


cd ..

cp -r ./$dir/* ./$backupdir/$currentDate

while(true)
do
	sleep $interval_secs
	# echo hi
	
	ls -lR $dir > ./directory-info-new.txt
	
	if cmp -s directory-info-last.txt directory-info-new.txt
	then
		continue
	else
		cd ./$backupdir
		currentDate=$(date +%Y-%m-%d-%H-%S-%M)
		if [ $backupNO -ge $max_backups ]
		then
			#echo "out of range"
			rm -R $(ls -1t | tail -1)
			backupNO=`expr $backupNO - 1`
		fi
		mkdir $currentDate
		backupNO=`expr $backupNO + 1`
		cd ..
		cp -r ./$dir/* ./$backupdir/$currentDate
		cp -r directory-info-new.txt directory-info-last.txt
	fi
done
