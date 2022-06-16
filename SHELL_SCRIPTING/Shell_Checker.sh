#! /bin/bash
#echo $lines
txt_location=$HOME/Desktop/VODAFONE/SHELL_SCRIPTING/hello.txt
sh_location=$HOME/Desktop/VODAFONE/SHELL_SCRIPTING/Shell.sh
base_location=$HOME/Desktop/VODAFONE/SHELL_SCRIPTING
for i in {1..30}
do
	process=$(ps aux | grep '[S]hell.sh' | awk '{print $2}')
	lines=$(cat $txt_location | wc -l)
	if [ $lines -eq "10" ];
	then 
		kill -9 $process
		rm $txt_location
		setsid $sh_location > $base_location/output.log 2>&1 < $base_location/output.log &
		echo "hello.txt deleted..."
	else
		echo "hello.txt lines lower than 10 or not equal"
	fi
	sleep 2
done
