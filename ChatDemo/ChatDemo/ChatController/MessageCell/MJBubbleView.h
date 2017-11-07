//
//  MJBubbleView.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  气泡View

#import <UIKit/UIKit.h>


@interface MJBubbleView : UIView

- (instancetype)initWithIsSender:(BOOL)isSender;

/// 是否是发送方
@property (nonatomic, assign) BOOL isSender;

/// 背景Img
@property (nonatomic, strong) UIImageView *imgViewBackground;



/// text views 文本
@property (nonatomic, strong) UILabel *lblText;

/// image views 图片
@property (strong, nonatomic) UIImageView *imgView;

/// voice views 语言
/// 语言图片
@property (strong, nonatomic) UIImageView *imgViewVoice;
/// 语言长度
@property (strong, nonatomic) UILabel *lblVoiceDuration;
/// 语言是否已经播放了
@property (strong, nonatomic) UIImageView *imgViewIsRead;

@end
