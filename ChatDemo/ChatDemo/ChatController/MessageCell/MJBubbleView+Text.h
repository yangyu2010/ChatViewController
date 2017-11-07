//
//  MJBubbleView+Text.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/7.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  气泡view 文字

#import "MJBubbleView.h"

@interface MJBubbleView (Text)

/// 设置ui界面
- (void)setupTextBubbleView;

/// 更新frame
- (void)updateTextBubbleViewFrameIsSender:(BOOL)isSender;

@end
