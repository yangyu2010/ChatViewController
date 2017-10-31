//
//  ChatToolBar.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  底部toolbar

#import <UIKit/UIKit.h>
#import "ChatToolInputView.h"

@protocol ChatToolBarDelegate <NSObject>

/// 每次换行时通知外面改变高度 height是每次变化的高度
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height;

- (void)chatToolBarSendText:(NSString *)text;

@end

@interface ChatToolBar : UIView

@property (nonatomic, weak) id <ChatToolBarDelegate> delegate;

@end
