//
//  ChatToolBar.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  底部toolbar

#import <UIKit/UIKit.h>
#import "ChatToolInputView.h"
#import "VoiceRecordHeader.h"



@protocol ChatToolBarDelegate <NSObject>

/*******************************文本处理*******************************/

/// 每次换行时通知外面改变高度 height是每次变化的高度
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height;
///// 重置当前inputView高度
//- (void)chatToolBarResetInputViewHeight;
/// 发送文字
- (void)chatToolBarSendText:(NSString *)text;


/*******************************录音处理*******************************/

/// 点击录音按钮
- (void)chatToolBarVoiceRecoredActionState:(BOOL)isSelected;
/// 录音各种状态的处理
- (void)chatToolBarVoiceRecordState:(VoiceRecordState)state;


/*******************************More处理*******************************/

/// 点击moreView
- (void)chatToolBarMoreViewActionState:(BOOL)isSelected;

@end

@interface ChatToolBar : UIView

/// 点击空白时 需要复位当前的状态
- (void)resetState;

@property (nonatomic, weak) id <ChatToolBarDelegate> delegate;

@end
