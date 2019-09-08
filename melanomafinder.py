from skimage import color
from skimage import io
import numpy as np
import cv2
from PIL import Image

image = cv2.imread("img2.jpg")
output = image.copy()
image = cv2.medianBlur(image,5)
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

circles = cv2.HoughCircles(gray, cv2.HOUGH_GRADIENT, 1.2, 100)
circles = np.uint16(np.around(circles[0]))
r = circles[0][2]
print(r)

for (x, y, z) in circles:
	cv2.circle(output, (x, y), z, (0, 255, 0), 4)
	cv2.rectangle(output, (x - 5, y - 5), (x + 5, y + 5), (0, 128, 255), -1)

cv2.namedWindow("output", cv2.WINDOW_NORMAL)        # Create window with freedom of dimensions
cv2.imshow("output", output)
cv2.waitKey(5000)


im = Image.open('img1.jpg')
pixels = im.getdata()          # get the pixels as a flattened sequence
black_thresh = 70
nblack = 0
for pixel in pixels:
    if sum(pixel) < black_thresh:
        nblack += 1
print(nblack)
