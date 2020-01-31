#!/bin/bash
start=$SECONDS
echo ""
echo "*Started Process*"
echo ""
FILES="/mnt/c/Users/THOR-09/Documents/Github/BlurryFinder/Images/*"
num_Files=0
i=0
for f in $FILES
do
	tail="${f#/*/*/*/*/*/*/*/*/}"
	main="main.py"
	script="script.sh"
	text="text.txt"
	burry="Blurry"
	zero=0
	if [ $tail != $main ]
	then
		if [ $tail != $script ]
		then
			if [ $tail != $zero ]
			then
				python3 main.py $tail > text.txt
				output=$(tail text.txt)

				if [ "$output" ==  "Blurry" ]
				then
					echo "$tail is Blurry"
					echo ""
					i=$((i+1))
				fi
			
				num_Files=$((num_Files+1))
			fi
		fi
	fi
done
echo "$num_Files TOTAL IMAGES."
echo "$i ARE BLURRY."

FILES='/mnt/c/Users/THOR-09/Documents/Github/BlurryFinder/Images/*'
i=0
dsum=0
for f in $FILES
do
	tail="${f#/*/*/*/*/*/*/*/*/}"
	main="main.py"
	script="script.sh"
	text="text.txt"
	zero=0

	if [ $tail != $main ]
	then
		if [ $tail != $text ]
		then
			if [ $i == $zero ]
			then
				cp $tail pI.JPG

			else

				python3 distance.py pI.JPG $tail > distance.txt
				output=$(tail distance.txt)
				dsum=$(($dsum+output))
				rm pI.JPG
				cp $tail pI.JPG
				rm distance.txt
				

			fi 	

		fi


	fi
	i=$((i+1))

done
distro=$((dsum/num_Files))

echo "Distribution of images is: $distro meters"

stopTime=$((SECONDS - start))

echo "*** TIMES: $stopTime seconds ***"

