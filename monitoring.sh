alert=10
partition='D:'

res=$(df -H | grep -E $partition | awk '{{print $6 " " $1}'})

for i in $res 
do
	if [[ $i =~ %$ ]]
	then
		i=$(echo $i | cut -d% -f1)
		#echo $i
		if (( $i >= $alert ))
		then
			if [[ -f 'Storage_log.txt' ]]
			then
				echo "This is an alert for you because the disk space in '$partition' have exceeded the limit which is '$alert'% and have become '$res' in date time." >> Storage_log.txt
			else
				touch Storage_log.txt
				echo "This is an alert for you because the disk space in '$partition' have exceeded the limit which is '$alert'% and have become '$res' in date time." >> Storage_log.txt
			fi
		fi
	fi
done