# -*- coding: utf-8 -*-
"""
Created on Fri Aug 04 16:10:32 2017



@author: Administrator
"""
import cv2
from math import *   
import numpy as np
from PIL import Image 
from fugai import *
#import os

    
    
    
def imrotate_zz250(img,theta):
    w = 770
    h = 430
    img = cv2.resize(img,(w,h),interpolation = cv2.INTER_CUBIC)
    height,width=img.shape[:2]
    heightNew=int(width*fabs(sin(radians(theta)))+height*fabs(cos(radians(theta))))
    widthNew=int(height*fabs(sin(radians(theta)))+width*fabs(cos(radians(theta))))
    
    matRotation=cv2.getRotationMatrix2D((width/2,height/2),theta,1)
    
    matRotation[0,2] +=(widthNew-width)/2  #重点在这步，目前不懂为什么加这步
    matRotation[1,2] +=(heightNew-height)/2  #重点在这步
    
    imgRotation=cv2.warpAffine(img,matRotation,(widthNew,heightNew),borderValue=(0,0,0))
    return imgRotation

def imrotate_zz248(img,theta,color):
    w = 670
    h = 330
    img = cv2.resize(img,(w,h),interpolation = cv2.INTER_CUBIC)
    height,width=img.shape[:2]
    heightNew=int(width*fabs(sin(radians(theta)))+height*fabs(cos(radians(theta))))
    widthNew=int(height*fabs(sin(radians(theta)))+width*fabs(cos(radians(theta))))
    
    matRotation=cv2.getRotationMatrix2D((width/2,height/2),theta,0.8)
    
    matRotation[0,2] +=(widthNew-width)/2  #重点在这步，目前不懂为什么加这步
    matRotation[1,2] +=(heightNew-height)/2  #重点在这步
    imgRotation=cv2.warpAffine(img,matRotation,(int(widthNew),int(heightNew)),borderMode=0,borderValue=color)
    return imgRotation

    
def transform_zz250(img,M):
    dst = cv2.warpAffine(img,M,(430,770),borderValue=(0,0,0))
    return dst
def transform_zz248(img,M):
    img = cv2.resize(img,(int(0.85*img.shape[1]), int(0.85*img.shape[0])),interpolation = cv2.INTER_CUBIC)
    dst = cv2.warpAffine(img,M,(770,430),borderValue=(0,0,0))
    return dst



I_248 = cv2.imread('./fish_248/100.jpg')
mask_248 = np.ones(((I_248.shape[0],I_248.shape[1],3)))/255
mask_248_inv = np.zeros(((I_248.shape[0],I_248.shape[1],3)))
I_249 = cv2.imread('./fish_249/100.jpg')
mask_249 = np.ones(((I_249.shape[0],I_249.shape[1],3)))
I_250 = cv2.imread('./fish_250/100.jpg')
mask_250 = np.ones(((I_250.shape[0],I_250.shape[1],3)))

theta_248 = 3      ##248旋转的角度
theta_249 = -3  ##249旋转的角度
theta_250 = 90
dx_248 = 250+600    ##248水平位移
dy_248 = 150
dx_249 = 200+550
dy_249= 480
dx_250 = 287
dy_250= 72
## 248和249平移的矩阵
T_248 = np.float32([[1,0,dx_248],[0,1,dy_248]])
T_249 = np.float32([[1,0,dx_249],[0,1,dy_249]])
T_250 = np.float32([[1,0,dx_250],[0,1,dy_250]])



##248，249，250的旋转
I_248_R = imrotate_zz248(I_248,theta_248,None)
mask_248 = imrotate_zz248(mask_248,theta_248,None)
mask_248_inv = imrotate_zz248(mask_248,theta_248,[255,255,255])
I_249_R = imrotate_zz248(I_249,theta_249,None)
mask_249 = imrotate_zz248(mask_249,theta_249,None)
mask_249_inv = imrotate_zz248(mask_248,theta_249,[255,255,255])
I_250_R = imrotate_zz250(I_250,theta_250)
mask_250 = imrotate_zz250(mask_250,theta_250)

##248，249,250的平移
#I_248_T = transform_zz248(I_248_R,T_248)
#mask_248 = transform_zz248(mask_248,T_248)
#I_249_T = transform_zz248(I_249_R,T_249)
#mask_249 = transform_zz248(mask_249,T_249)


I_250_T = transform_zz250(I_250_R,T_250)
mask_250_T = transform_zz250(mask_250,T_250)


## 图像的合成
img_basic = cv2.imread('basic.jpg')

mask_248_255 = mask_248*255*255
mask_249_255 = mask_249*255*255


cv2.imwrite('mask248.jpg',mask_248_255)
cv2.imwrite('mask248_inv.jpg',mask_248_inv)
cv2.imwrite('mask249.jpg',mask_249_255)
cv2.imwrite('mask249_inv.jpg',mask_249_inv)

img_out = fugai(img_basic,I_250_R,dx_250,dy_250)
#img_out = fugai(img_out,I_248_R,dx_248,dy_248)
#cv2.imwrite('img_out.jpg',img_out)
#img1 = cv2.imread('img_out.jpg')
#img2 = cv2.imread('248_R.jpg')
mask_248_p = cv2.imread('mask248.jpg')
mask_248_inv_p = cv2.imread('mask248_inv.jpg')
mask_249_p = cv2.imread('mask249.jpg')
mask_249_inv_p = cv2.imread('mask249_inv.jpg')

img_out2 = transparent(img_out,I_248_R,mask_248_p,mask_248_inv_p,800,300)
#img_out3 = transparent(img_out2,I_249_R,mask_249_p,mask_249_inv_p,800,600)
#img_out2 = transparent(img_out,I_248_R,mask_248_255,mask_248_inv,100,100)
cv2.imshow('img_out',img_out2)


cv2.imwrite('248_R.jpg',I_248_R)
cv2.waitKey(0)
cv2.destroyAllWindows()
























