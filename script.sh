#THIS SCRIPT GOES THROUGH EACH JPG IN THE FOLDER
#IT IS IN. FIRST, THE NAME OF EACH FILE THE SCRIPT
#IS PROCESSING IS DISPLAYED, AND SAYS ITS IS EITHER
#BLURRY, SKEWED, OR NOTHING BASED ON THE THRESHOLD IN
#THE PYTHON PROGRAMS FOR VARIANCE AND SKEWNESS.
#
#example to run:
#$./script.sh 25 .50

#arg1 = Laplacian Var Threshold, 
#	
#	sucess range: (0, arg1)
#
#arg2 = Skewness Threshold, 
#	
#	success range: (-INF, -arg2)U(arg2, INF)
#
#author: Manvel Beaver

#!/bin/bash
#START PROGRAM TIME
start=$SECONDS
echo ""
echo "*Started Process*"
echo ""
FILES="$PWD/*"
#NEED TO KEEP TRACK OF HOW MANY IMAGES ARE
#IN THE FOLDER FOR RATIO AND DISTRIBUTION
#CALCULATIONS

num_Files=0
#ITERATORS FOR NUMBER OF BLURRY AND SKEWED IMAGES
i=0
j=0
for f in *.JPG
do
	echo "*** $f ***"
	echo ""
	#TAKES PRINT OUTPUT FROM PYTHON PROGRAM
	#AND PIPES IT TO AN EMPTY TEXT FILE	
	python3 main.py -B $1 $f > text.txt
	output=$(tail text.txt)
	if [ "$output" ==  "Blurry" ]
	then
		echo "1.)--> Blurry"
		echo ""
		i=$((i+1))
	fi
	#REMOVE TO REMAKE
	rm text.txt
	#NEED TO KEEP TRACK OF HOW MANY IMAGES ARE
	#IN THE FOLDER FOR RATIO AND DISTRIBUTION
	#CALCULATIONS
	num_Files=$((num_Files+1))
	
	#SAME AS BURRY BUT PIPING AS SKEWED PRINT
	python3 main.py -S $2 $f > text.txt
	output=$(tail text.txt)
	if [ "$output" ==  "Skewed" ]
	then
		echo "2.)--> Skewed"
		echo ""
		j=$((j+1))
	fi
	rm text.txt
done
echo "$num_Files TOTAL IMAGES."
echo "$i ARE BLURRY."
echo "$j ARE SKEWED."

#ITERATOR NEEDED ONLY FOR ONE LOOP
i=0
#SUMS EACH DISTANCE OUTPUT
dsum=0
for f in *.JPG
do
	zero=0
	echo "$f"
	if [ $i == $zero ]
	then
		#NEED TO INDEX FROM ONE IMAGE
		#TO THE NEXT SEQUENTIALLY, SO
		#WE COPY THE FIRST IMAGE IN 
		#THE FOLDER AND MOVE TO THE NEXT.
		cp $f pI.JPG
	else
		#TAKES PREVIOUSLY COPIED IMAGE
		#AND USES IT AS ARG FOR PYTHON
		#PROGRAM TO COMPUT DISTANCE BETWEEN
		#THEM
		python3 distance.py pI.JPG $f > distance.txt
		output=$(tail distance.txt)
		if [ $output == $zero ]
		then
			i=$((i-1))
		else
			dsum=$(($dsum+output))
		fi
		rm pI.JPG
		cp $f pI.JPG
		rm distance.txt
	fi 	
	i=$((i+1))
done

#THIS IS WHERE NUM_FILES COMES INTO PLAY
distro=$((dsum/i))

echo "Distribution between images is: $distro meters"
#END PROGRAM TIME
stopTime=$((SECONDS - start))

echo "*** TIME: $stopTime seconds ***"

