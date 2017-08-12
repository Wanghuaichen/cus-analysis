# -*- coding: utf-8 -*-
"""
Created on Tue Aug 08 14:55:36 2017

@author: Administrator
"""

import cv2
import numpy as np
from calibration_zz import img_unfish




cofes248 = np.load('mtx248.npz')
mtx248 = cofes248['arr_0']
dist248 = cofes248['arr_1']

cofes250 = np.load('mtx250.npz')
mtx250 = cofes250['arr_0']
dist250 = cofes250['arr_1']


def plotPoints(img,ori_points):
    for i in range(ori_points.shape[1]):
        x = ori_points[:,i,0]   
        y = ori_points[:,i,1]
    
    
        cv2.circle(img,(x,y),5,(0,0,255),2)

## 寻找250摄像头对应的坐标
def unfishPoints250(img,ori_points,mtx,dist):
    
    h,w=img.shape[:2]
    newcameramtx,roi=cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h),1,(w,h))
    x,y,w,h = [130,130,900,600]
    img_undist = cv2.undistort(img,mtx,dist,None,newcameramtx)
    img_undist2 = np.zeros(((720,1280,3)))
    img_undist2= img_undist[y:y+h, x:x+w]
    update_points = cv2.undistortPoints(ori_points,mtx,dist,R = None,P= newcameramtx)  ##计算矫正后的坐标
    update_points2 = update_points-130                                


    plotPoints(img,ori_points)
    cv2.imshow('img',img)
#    plotPoints(img_undist,update_points)
#    cv2.imshow('undistort', img_undist)
    plotPoints(img_undist2,update_points2)
    cv2.imshow('undistort2', img_undist2)
    cv2.waitKey(0)
    cv2.destroyAllWindows() 
    print update_points

def unfishPoints248(img,ori_points,mtx,dist):
    
   
    img_undist = cv2.undistort(img,mtx,dist)
    update_points = cv2.undistortPoints(ori_points,mtx,dist,R = None,P= mtx)  ##计算矫正后的坐标
#    cv2.circle(img,(ori_points[0,0,0],ori_points[0,0,1]),5,(0,0,255),2)                                  
    plotPoints(img,ori_points)
    cv2.imshow('img',img)
#    cv2.circle(img_undist,(update_points[0,0,0],update_points[0,0,1]),5,(0,0,255),2)
    plotPoints(img_undist,update_points)    
    cv2.imshow('undistort', img_undist)

    print update_points
    cv2.waitKey(0)
    cv2.destroyAllWindows() 
    

img248 = cv2.imread('./248/300.jpg')
img250 = cv2.imread('./250/300.jpg')

testpoints250 = np.array([[[350,250],[350,400]]],dtype = np.float32)   ## 获取原图中的坐标
unfishPoints250(img250,testpoints250,mtx250,dist250)
unfishPoints248(img248,testpoints250,mtx248,dist248)


#img = cv2.imread('./250/300.jpg')
#
#chesspath = './room250/*.jpg'
#mtx,dist = img_unfish(chesspath)
#
#R = np.array([[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0]],dtype = np.float32)
#
#h,w=img.shape[:2]
#newcameramtx,roi=cv2.getOptimalNewCameraMatrix(mtx,dist,(w,h),1,(w,h))
##dst = cv2.undistort(img, mtx, dist, None, newcameramtx)
##
##x,y,w,h = [100,100,1000,500]
##dst = dst[y:y+h, x:x+w]
##cv2.imshow('calibresult', dst)
#
#
#img_undistorted = cv2.undistort(img,mtx,dist,None,newcameramtx)
#dst = img_undistorted
#x,y,w,h = [100,100,1000,600]
#dst = dst[y:y+h, x:x+w]
#cv2.imshow('calibresult', dst)
#
#testpoints3 = np.array([[[900,200]]],dtype = np.float32)   ## 获取原图中的坐标
#result3 = cv2.undistortPoints(testpoints3,mtx,dist,R = None,P= newcameramtx)  ##矫正后点的坐标
#cv2.circle(img,(testpoints3[0,0,0],testpoints3[0,0,1]),5,(0,0,255),2)
#cv2.imshow('img',img)
#cv2.circle(img_undistorted,(result3[0,0,0],result3[0,0,1]),5,(0,0,255),2)
#cv2.imshow('undistorted', img_undistorted)
##cv2.imshow('undistorted2', dst)
#
#cv2.waitKey(0)
#cv2.destroyAllWindows()           
           
      
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           
           