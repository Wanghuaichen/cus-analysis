# -*- coding: utf-8 -*-
"""
Created on Thu Aug 10 11:12:32 2017

## 相机标定

@author: Administrator
"""

import numpy as np
import cv2
import glob

def img_unfish(chesspath):
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)
    
    objp = np.zeros((9*7,3), np.float32)
    objp[:,:2] = np.mgrid[0:9,0:7].T.reshape(-1,2)
    
    objpoints = [] # 3d point in real world space
    imgpoints = [] # 2d points in image plane.
    
    images = glob.glob(chesspath)
    
    for fname in images:
        img =cv2.imread(fname)
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        
        ret,corners = cv2.findChessboardCorners(gray,(9,7),None)
        if ret == True:
            objpoints.append(objp)
            corners2 = cv2.cornerSubPix(gray,corners,(11,11),(-1,-1),criteria)
            imgpoints.append(corners2)
            
            img = cv2.drawChessboardCorners(img,(9,7),corners2,ret)
#            cv2.imshow('img',img)
#            cv2.waitKey(50)
            
#    cv2.destroyAllWindows()
    
    ## 进行标定
    ret,mtx,dist,rvecs,tvecs=cv2.calibrateCamera(objpoints,imgpoints,gray.shape[::-1],None,None)
#    ret,mtx,dist,rvecs,tvecs = cv2.fisheye.calibrate(objpoints,imgpoints,gray.shape[::-1], None, None)
    return mtx,dist

#def img_unTong():
    
    
    
    
