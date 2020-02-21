SUMMARY:

This program is intended to index through a folder of images and determines there sharpenss, exposure, and distribution of distance between each sequential image in the folder. UNITS OF DISTANCE ARE CONVERTED TO METERS.

The main driver is the script.sh file which indexes the images, while the python files make the calculations.

TO RUN:

`$./script.sh <BLUR_THRESHOLD> <SKEW_THRESHOLD>`

ENVIRONMENTAL REQUIREMENTS:

+ Windows 10
+ Bash 4.4.0 and Git 2.17.1
+ Python 2.7.15+, 3.6.8
+ CV2 3.2.0
+ Scipy 1.4.1
+ exif 

INSTALLATION:

Here is a link to download the shell I used for this project.

Ubuntu 16: https://www.microsoft.com/en-us/p/ubuntu-1604-lts/9pjn388hp8c9?activetab=pivot:overviewtab

Here is a script that you can copy and past into your terminal(shell) to install the packages you will need. Comment out the ones you dont.
```
#!/bin/bash

#Installing Python2
sudo apt-get install python=2.7.15+

#Installing pip
sudo apt-get install pip

#Installing python3
sudo apt-get install python=3.6.2

#Installing pip3
sudo apt-get install pip3

#Installing git
sudo apt-get install git

#Installing OpenCV
git clone https://github.com/opencv/opencv.git
cd ~/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D BUILD_EXAMPLES=ON ..
cd ../..
rm opencv

#Installing Scipy
python -m pip install --user scipy

#Installing exif
python -m pip install --user exif

#Installing Image Curator
git clone https://github.com/manvelh/ImageCurator.git
cd ImageCurator
#mkdir Images
```

Once you have all the packages downloaded properly, alone with the program, move the program
into the image folder.

To run the program type:

`./script.sh 20 .5 2>/dev/null`

Exclude `2>/dev/null` if you wish to see the error messages that pop up.




