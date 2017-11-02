//
//  ChatController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatController.h"
#import "ChatToolBar.h"
#import "UIColor+Utils.h"
#import "UIView+Sugar.h"
#import "VoiceRecordController.h"

#define kChatToolBarHeight                   49.0

/// 录音定时器 间隔
#define KRecordTimerDuration                 0.2
/// 最多录制时间
#define kRecordMaxRecordDurtion              10
/// 剩余多少s开始提示用户
#define kRecordRemainCountingDuration        5

@interface ChatController () <ChatToolBarDelegate>
{
    /// 底部toolbar的高度
    CGFloat _toolBarViewHeight;
    /// 底部toolbar y值
    CGFloat _toolBarViewY;

    /// 定时器
    NSTimer *_timerVoice;
    /// 当前录制的时间
    float _recordCurrentDuration;
    /// 当前的录音状态
    VoiceRecordState _recordCurrentState;

}

/// 底部toolbar
@property (nonatomic, strong) ChatToolBar *toolBar;

/// 录制显示的View
@property (nonatomic, strong) VoiceRecordController *ctrVoiceRecord;

@end

@implementation ChatController

#pragma mark- Init


#pragma mark- Life cricle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    [self dataConfig];
    [self actionAddNotifications];
}

#pragma mark- UI

- (void)viewConfig {
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    self.title = @"聊天";

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewTap)];
    [self.view addGestureRecognizer:tap];
    
    self.toolBar = [[ChatToolBar alloc] init];
    [self.view addSubview:self.toolBar];
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = [[UIScreen mainScreen] bounds].size.height - _toolBarViewHeight;
    
    self.ctrVoiceRecord = [[VoiceRecordController alloc] init];

}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.toolBar.frame = CGRectMake(0, _toolBarViewY, self.view.bounds.size.width, _toolBarViewHeight);
    
//    self.viewRecord.frame = CGRectMake(0, 0, 150, 150);
//    self.viewRecord.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
}

#pragma mark- Data

- (void)dataConfig {
    
    self.toolBar.delegate = self;
    
    _recordCurrentDuration = 0;
    
    _recordCurrentState = VoiceRecordStateNoraml;
    
}


#pragma mark- Notification

/// 添加通知
- (void)actionAddNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
}

/// 监听键盘事件 改变table 和 输入框的位置
- (void)actionKeyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [UIView animateWithDuration:duration animations:^{
        self.toolBar.y = endFrame.origin.y - _toolBarViewHeight;;
    }];
}

/// 键盘将要出现
- (void)actionKeyboardWillShow {
    
}

- (void)actionKeyboardWillHide {
    
}

#pragma mark- Action

/// 重置当前toolBar的frame
- (void)actionResetToolBarFrame {
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = CGRectGetMaxY(self.toolBar.frame) - _toolBarViewHeight;
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.15f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)actionViewTap {
    [self.view endEditing:YES];
}

#pragma mark- 输入框处理 相关
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height {

    _toolBarViewHeight += height;
    _toolBarViewY = self.toolBar.y - height;
    
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.10f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)chatToolBarResetInputViewHeight {
    [self actionResetToolBarFrame];
}

- (void)chatToolBarSendText:(NSString *)text {
    
    NSLog(@"发送消息: %@", text);
    
    [self actionResetToolBarFrame];
}

#pragma mark- 录制语音 相关
/// 循环调用的方法
- (void)actionRecordVoiceTimeOut {
    
    _recordCurrentDuration += KRecordTimerDuration;
    float remainTime = kRecordMaxRecordDurtion - _recordCurrentDuration;
    if ((int)remainTime == 0) {
        // 录制结束
        [self actionRecordVoiceFinished];
    } else if ([self actionRecordVoiceViewShouldCounting]) {
        // 倒计时
        _recordCurrentState = VoiceRecordStateTouchUpCounting;
        [self actionUpdateVoiceRecordState];
        [self.ctrVoiceRecord updateCountingRemainTime:remainTime];
    } else {
        // 正在录制
        float fakePower = (float)(1 + arc4random() % 99) / 100;
        [self.ctrVoiceRecord updateRecordingPower:fakePower];
    }
}

/// 开始定时器 录制
- (void)actionStartRecordVoiceTimer {
    if (_timerVoice) {
        [_timerVoice invalidate];
        _timerVoice = nil;
    }
    
    _timerVoice = [NSTimer scheduledTimerWithTimeInterval:KRecordTimerDuration target:self selector:@selector(actionRecordVoiceTimeOut) userInfo:nil repeats:YES];
    [_timerVoice fire];
}

/// 结束定时器
- (void)actionStopRecordVoiceTimer {
    if (_timerVoice) {
        [_timerVoice invalidate];
        _timerVoice = nil;
    }
}

/// 更新状态
- (void)actionUpdateVoiceRecordState {
    
    if (_recordCurrentState == VoiceRecordStateStart) {
        [self actionStartRecordVoiceTimer];
    }
    else if (_recordCurrentState == VoiceRecordStateCanceled ||
             _recordCurrentState == VoiceRecordStateFinished) {
        [self actionRecordVoiceFinished];
    }
    [self.ctrVoiceRecord updateUIWithRecordState:_recordCurrentState];
}

/// 录制语音结束
- (void)actionRecordVoiceFinished {

    [self actionStopRecordVoiceTimer];
    _recordCurrentDuration = 0;
    _recordCurrentState = VoiceRecordStateNoraml;
    [self.ctrVoiceRecord updateUIWithRecordState:_recordCurrentState];
}

/// 判断当前录制的view 是否需要显示 倒计时
- (BOOL)actionRecordVoiceViewShouldCounting {
    
    if ((_recordCurrentDuration >= (kRecordMaxRecordDurtion - kRecordRemainCountingDuration)) &&
        (_recordCurrentDuration < kRecordMaxRecordDurtion) &&
        (_recordCurrentState != VoiceRecordStateTouchUpCancel)) {
        
        return YES;
    }
    
    return NO;
}

- (void)chatToolBarVoiceRecordState:(VoiceRecordState)state {
    _recordCurrentState = state;
    
    [self actionUpdateVoiceRecordState];
}

@end
