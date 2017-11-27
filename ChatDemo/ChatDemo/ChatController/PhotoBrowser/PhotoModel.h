//
//  PhotoModel.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface PhotoModel : NSObject

- (instancetype)initWithMessageModel:(MessageModel *)model;

/// 消息id
@property (nonatomic, copy) NSString *messageId;

/// 大图的size
@property (nonatomic, assign) CGSize imageSize;

/// 大图的地址
@property (nonatomic, copy) NSString *imageURLString;

/// 大图 如果没有就取大图地址
@property (nonatomic, strong) UIImage *image;

/// 小图用来占位
@property (nonatomic, strong) UIImage *placeholderImage;


@end
