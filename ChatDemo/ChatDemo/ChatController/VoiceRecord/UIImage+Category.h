//
//  UIImage+Category.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

/**
 根据颜色来生产图片, 默认大小

 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 根据颜色来生产图片, 可以设置大小

 @param color 颜色
 @param size 大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end
