//
//  PhotoModel.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject

/// 大图的size
@property (nonatomic, assign) CGSize imageSize;

/// 大图的地址
@property (nonatomic, copy) NSString *imageURLString;

/// 小图用来占位
@property (nonatomic, strong) UIImage *placeholderImage;


@end
