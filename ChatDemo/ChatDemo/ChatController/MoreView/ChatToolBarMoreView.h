//
//  ChatToolBarMoreView.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  + 更多的view

#import <UIKit/UIKit.h>

@class ChatToolBarMoreView;

@protocol ChatToolBarMoreViewDelegate <NSObject>

/// 照片库
- (void)chatToolBarMoreViewPictureAction:(ChatToolBarMoreView *)view;

/// 拍照
- (void)chatToolBarMoreViewShootAction:(ChatToolBarMoreView *)view;

@end

@interface ChatToolBarMoreView : UIView

@property (nonatomic, weak) id <ChatToolBarMoreViewDelegate> delegate;

@end
