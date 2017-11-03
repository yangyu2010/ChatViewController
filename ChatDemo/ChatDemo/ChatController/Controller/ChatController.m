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
#import "ChatToolBarMoreView.h"
#import "ChatToolBarHeader.h"

#define kChatToolBarHeight                   49.0

#define KChatToolBarMoreViewHeight           200.0

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
    /// 记录toolbar高度, _toolBarViewHeight有时会被情况, 当前这个值会保留当前输入框里文字的高度
    CGFloat _toolBarViewOriginHeight;
    /// 底部toolbar y值
    CGFloat _toolBarViewY;
    /// 底部moreView y值
    CGFloat _toolBarMoreViewY;
    /// 当前toolbar的状态
    ChatToolBarState _chatToolBarState;
    
    /// 是否需要根据键盘来调整页面
    BOOL _isNeedNotifKeyboard;
    
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

/// +号更多 View
@property (nonatomic, strong) ChatToolBarMoreView *viewMore;


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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.toolBar beginEditing];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- UI

- (void)viewConfig {
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    self.title = @"聊天";

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewTap)];
    [self.view addGestureRecognizer:tap];
    
    self.toolBar = [[ChatToolBar alloc] init];
    [self.view addSubview:self.toolBar];
    
    self.ctrVoiceRecord = [[VoiceRecordController alloc] init];

    self.viewMore = [[ChatToolBarMoreView alloc] init];
    [self.view addSubview:self.viewMore];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.toolBar.frame = CGRectMake(0, _toolBarViewY, self.view.bounds.size.width, _toolBarViewHeight);
    
    self.viewMore.frame = CGRectMake(0, _toolBarMoreViewY, self.view.bounds.size.width, KChatToolBarMoreViewHeight);
}

#pragma mark- Data

- (void)dataConfig {
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewOriginHeight = 0;
    _toolBarViewY = [[UIScreen mainScreen] bounds].size.height - _toolBarViewHeight;
    _toolBarMoreViewY = [[UIScreen mainScreen] bounds].size.height;
    
    _chatToolBarState = ChatToolBarStateNoraml;
    
    self.toolBar.delegate = self;
    
    _recordCurrentDuration = 0;
    
    _recordCurrentState = VoiceRecordStateNoraml;
    
    _isNeedNotifKeyboard = YES;
}


#pragma mark- Notification

/// 添加通知
- (void)actionAddNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/// 监听键盘事件 改变table 和 输入框的位置
- (void)actionKeyboardWillChangeFrame:(NSNotification *)notification {

    if (_isNeedNotifKeyboard == NO) {
        _isNeedNotifKeyboard = YES;
        return ;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    _toolBarViewY = endFrame.origin.y - _toolBarViewHeight;
    
    [self actionUpdateLayoutDuration:duration];
}

#pragma mark- Action

/// 重置当前toolBar的frame
- (void)actionResetToolBarFrame {
    
    _chatToolBarState = ChatToolBarStateNoraml;
    _toolBarViewOriginHeight = _toolBarViewHeight;
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = CGRectGetMaxY(self.toolBar.frame) - _toolBarViewHeight;
    
    [self actionUpdateLayoutDuration:0];
}

/// 点击空白处 放弃编辑
- (void)actionViewTap {
    
    if (_toolBarViewY >= self.view.height - _toolBarViewHeight) {
        return ;
    }
    
    _chatToolBarState = ChatToolBarStateNoraml;
    _toolBarMoreViewY = self.view.height;
    _toolBarViewY = self.view.height - _toolBarViewHeight;
    [self actionUpdateLayoutDuration:0.0f];
    [self.toolBar resetState];

}

/// 刷新界面 duration为0则是默认值
- (void)actionUpdateLayoutDuration:(CGFloat)duration {
    
    if (duration <= 0) {
        duration = 0.25f;
    }
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark- 输入框处理 相关
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height {

    _toolBarViewHeight += height;
    _toolBarViewY = self.toolBar.y - height;
    
    [self actionUpdateLayoutDuration:0.10f];
}

- (void)chatToolBarSendText:(NSString *)text {
    
    NSLog(@"发送消息: %@", text);
    
    [self actionResetToolBarFrame];
    
    _toolBarViewOriginHeight = 0;
}

#pragma mark- More View 相关

/// 点击+事件
- (void)chatToolBarMoreViewActionState:(BOOL)isSelected {
    
    if (_toolBarViewOriginHeight != 0) {
        _toolBarViewHeight = _toolBarViewOriginHeight;
        _toolBarViewOriginHeight = 0;
    }
    
    if (isSelected) {
        _chatToolBarState = ChatToolBarStateMore;
        _toolBarMoreViewY = self.view.height - KChatToolBarMoreViewHeight;
        _toolBarViewY = _toolBarMoreViewY - _toolBarViewHeight;

    } else {
        _chatToolBarState = ChatToolBarStateInput;
        _toolBarMoreViewY = self.view.height;
        _isNeedNotifKeyboard = NO;
    }
    
    [self actionUpdateLayoutDuration:0];
}

#pragma mark- 录制语音 相关

/// 点击录音按钮事件
- (void)chatToolBarVoiceRecoredActionState:(BOOL)isSelected {
    
    if (_toolBarViewOriginHeight != 0) {
        _toolBarViewHeight = _toolBarViewOriginHeight;
        _toolBarViewOriginHeight = 0;
    }
    
    if (isSelected) {
        [self actionResetToolBarFrame];
        
        // 在录音
        _chatToolBarState = ChatToolBarStateVoice;
        _toolBarMoreViewY = self.view.height;
        _toolBarViewHeight = kChatToolBarHeight;
        _toolBarViewY = self.view.height - kChatToolBarHeight;
    } else {
        // 取消录音, 就是正在输入
        _chatToolBarState = ChatToolBarStateInput;
    }
    
    [self actionUpdateLayoutDuration:0];
}

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

    if (_recordCurrentDuration < 1.0) {
        [self.ctrVoiceRecord showToast:@"录制太短了..."];
    }
    
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
