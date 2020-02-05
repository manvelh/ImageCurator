#THIS PROGRAMS TAKES AN IMAGE AND COMPUTES
#AN IMAGE PROCESS BASED ON THE ARGUMENT TAG.

#USE -B TO CHECK FOR BLUR
#USE -S TO CHECK FOR SKEW

#THE LAPLACIAN VARIANCE WHICH IS THE INDICATOR
#OF A BLURRY IMAGE. IT ALSO COMPUTES THE HISTOGRAM
#SKEWNESS WHICH IS AN INDICATOR OF HOW EXPOSED AN
#IMAGE IS.
#
#author: Manvel Beaver

import sys
import cv2 as cv
from scipy.stats import skew

def main(argv):
	#1 CHANNEL OF SIGNED 2-BYTE INTEGER
	ddepth = cv.CV_16S
	#KERNEL FOR LAPLACE MATRIX
	kernel_size = 3
	#IMAGE FILE
	fileName = argv[2]
	#LOAD AND READ
	src = cv.imread(fileName, cv.IMREAD_COLOR)
	#CHECK IF SOURCE EXISTS
	if src is None:
		return -1
	#COMPUTE LAPLACIAN
	src = cv.GaussianBlur(src, (3, 3), 0)
	src_gray = cv.cvtColor(src, cv.COLOR_BGR2GRAY)
	dst = cv.Laplacian(src_gray, ddepth, ksize=kernel_size)

	if argv[0] == "-B":
		#COMPARES VAR TO ARG
		if dst.var() < float(argv[1]):
			#PRINT FOR OUTPUT PIPE
			print("Blurry")
	elif argv[0] == "-S": 
		
		img = cv.imread(fileName,0) 
		if img is None:
			return -1
		#COMPUTE HISTOGRAM
		histr = cv.calcHist([img],[0],None,[256],[0,256]) 
		#COMPARES SKEW TO ARG
		if skew(histr)[0] > float(argv[1]) or skew(histr) < -float(argv[1]):
			#PRINT FOR OUTPUT PIPE
			print("Skewed")
	return 0

#ARGS COLLECTED FROM SCRIPT
if __name__ == "__main__":
	main(sys.argv[1:])
