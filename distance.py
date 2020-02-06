#THIS PROGRAM TAKES IN TWO ARGUMENTS, IMAGE FILES,
#AND COMPUTES THE DISTANCE BETWEEN THEM WITH THE
#HAVERSINE FORMULA FOR DISTANCE.
#
#author: Manvel Beaver

from math import sin, cos, radians, degrees, asin, sqrt
import sys
from exif import Image
def main(argv):
	try:
		imageName1 = argv[0]
		imageName2 = argv[1]	

		#OPEN IMAGE FILES
		with open(imageName1, 'rb') as image_file1, open(imageName2, 'rb') as image_file2:
			my_image1, my_image2 = Image(image_file1), Image(image_file2)

		#CONVERT EXIF LAT,LON FROM ARC UNITS TO DEGREES
		latitude1 = my_image1.gps_latitude[0] + (my_image1.gps_latitude[1]/60) + (my_image1.gps_latitude[2]/3600)
		longitude1 = my_image1.gps_longitude[0] + (my_image1.gps_longitude[1]/60) + (my_image1.gps_longitude[2]/3600)
		latitude2 = my_image2.gps_latitude[0] + (my_image2.gps_latitude[1]/60) + (my_image2.gps_latitude[2]/3600)
		longitude2 = my_image2.gps_longitude[0] + (my_image2.gps_longitude[1]/60) + (my_image2.gps_longitude[2]/3600)
		#CAST FLOAT		
		lon1, lat1, lon2, lat2 = map(float, [longitude1, latitude1, longitude2, latitude2])
		#CONVERT TO RADIANS
		lon1, lat1, lon2, lat2 = map(radians, [longitude1, latitude1, longitude2, latitude2])
		#GET VECTOR VALUES
		dlon = lon2 - lon1
		dlat = lat2 - lat1
		#COMPUTE HAVERSINE
		f = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
		g = 2 * asin(sqrt(f))
		r = 6371000
		d = r * g
		#CAST AS INT FOR BASH TO INTERPRET
		d=int(d)
		print("%d" %(d))

		return 0
	
	except AttributeError as e:
		pass

if __name__ == "__main__":
	main(sys.argv[1:])
