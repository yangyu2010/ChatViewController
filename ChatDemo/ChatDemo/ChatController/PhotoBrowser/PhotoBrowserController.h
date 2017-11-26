//
//  PhotoBrowserController.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  图片浏览器vc

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface PhotoBrowserController : UIViewController

- (instancetype)initWithPhotos:(NSArray <PhotoModel *> *)arrPhotos
                         index:(NSInteger)index;

@end
