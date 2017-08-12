# -*- coding: utf-8 -*-
"""
Created on Fri Aug 11 16:51:21 2017
## 将两张图片重合叠加
@author: Administrator
"""

import cv2
import numpy
from PIL import Image


def fugai(background,logo,y,x):
    img1 = background
    img2 = logo
    # 我想把logo放在background上，起始位置为x,y
    rows,cols,channels = img2.shape
    img1[x:rows+x, y:cols+y] = img2 
#    cv2.imshow('res',img1)
    
    return img1

def transparent(background,logo,mask,mask_inv,x,y):
    img1 = background
    img2 = logo
    mask = mask[:,:,0]
    mask_inv = mask_inv[:,:,0]
    rows,cols,channels = img2.shape
    roi = img1[y:rows+y, x:cols+x ]
    img2gray = cv2.cvtColor(img2,cv2.COLOR_BGR2GRAY)
    img1_bg = cv2.bitwise_and(roi,roi,mask = mask_inv)
    img2_fg = cv2.bitwise_and(img2,img2,mask = mask)
    dst = cv2.add(img1_bg,img2_fg)
    img1[y:rows+y, x:cols+x ] = dst
#    cv2.imshow('res',img1)
#    cv2.imshow('mask',mask)
#    cv2.imshow('mask_inv',mask_inv)
    
#    cv2.waitKey(0)
#    cv2.destroyAllWindows() 
    return img1
    

#img1 = cv2.imread('basic.jpg')
#img2 = cv2.imread('248_R.jpg')
#mask = cv2.imread('mask248.jpg')
#mask_inv = cv2.imread('mask248_inv.jpg')
#
#transparent(img1,img2,mask,mask_inv,500,300)





"""
#设置滑块
    
#def CannyThreshold(lowThreshold):  
#    detected_edges = cv2.GaussianBlur(gray,(3,3),0)  
#    detected_edges = cv2.Canny(detected_edges,lowThreshold,lowThreshold*ratio,apertureSize = kernel_size)  
#    dst = cv2.bitwise_and(img,img,mask = detected_edges)  # just add some colours to edges from original image.  
#    cv2.imshow('canny demo',dst)  
#  
#lowThreshold = 0  
#max_lowThreshold = 200  
#ratio = 3  
#kernel_size = 3  
#  
#img = cv2.imread('248_R.jpg')  
#gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)  
#  
#cv2.namedWindow('canny demo')  
#  
#cv2.createTrackbar('Min threshold','canny demo',lowThreshold, max_lowThreshold, CannyThreshold)  
#  
#CannyThreshold(0)  # initialization  
#if cv2.waitKey(0) == 27:  
#    cv2.destroyAllWindows()    


#img = cv2.imread('248_R.jpg')
#rows,cols = img.shape[:2]
#
## Source points
#srcTri = np.array([(0,0),(cols-1,0),(0,rows-1)], np.float32)
#
## Corresponding Destination Points. Remember, both sets are of float32 type
#dstTri = np.array([(cols*0.0,rows*0.33),(cols*0.85,rows*0.25), (cols*0.15,rows*0.7)],np.float32)
#
## Affine Transformation
#warp_mat = cv2.getAffineTransform(srcTri,dstTri)   # Generating affine transform matrix of size 2x3
#dst = cv2.warpAffine(img,warp_mat,(cols,rows))     # Now transform the image, notice dst_size=(cols,rows), not (rows,cols)
#
## Image Rotation
#center = (cols/2,rows/2)                           # Center point about which image is transformed
#angle = -50.0                                      # Angle, remember negative angle denotes clockwise rotation
#scale = 0.6                                        # Isotropic scale factor.
#
#rot_mat = cv2.getRotationMatrix2D(center,angle,scale) # Rotation matrix generated
#dst_rot = cv2.warpAffine(dst,rot_mat,(cols,rows))     # Now transform the image wrt rotation matrix
#
#cv2.imshow('dst_rt',dst_rot)
#cv2.waitKey(0)
#cv2.destroyAllWindows()


"""

    
