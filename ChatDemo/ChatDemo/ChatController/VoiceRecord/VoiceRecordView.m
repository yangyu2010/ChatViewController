//
//  VoiceRecordView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "VoiceRecordView.h"
#import "VoiceRecordContentView.h"

@interface VoiceRecordView ()
{
    VoiceRecordState _state;
}

/// 背景透明View
@property (nonatomic, strong) UIView *viewBg;

/// 正在录制的View
@property (nonatomic, strong) VoiceRecordingView *viewRecording;

/// 取消的View
@property (nonatomic, strong) VoiceRecordReleaseToCancelView *viewCancle;

/// 倒计时View
@property (nonatomic, strong) VoiceRecordCountingView *viewCount;


@end

@implementation VoiceRecordView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}


#pragma mark- UI

- (void)viewConfig {
    
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    
    if (self.viewBg == nil) {
        self.viewBg = [[UIView alloc] init];
        self.viewBg.backgroundColor = [UIColor blackColor];
        self.viewBg.alpha = 0.6;
        [self addSubview:self.viewBg];
    }
    
    
    if (self.viewRecording == nil) {
        self.viewRecording = [[VoiceRecordingView alloc] init];
        [self addSubview:self.viewRecording];
        self.viewRecording.hidden = YES;
    }
    
    if (self.viewCancle == nil) {
        self.viewCancle = [[VoiceRecordReleaseToCancelView alloc] init];
        [self addSubview:self.viewCancle];
        self.viewCancle.hidden = YES;
    }
    
    if (self.viewCount == nil) {
        self.viewCount = [[VoiceRecordCountingView alloc] init];
        [self addSubview:self.viewCount];
        self.viewCount.hidden = YES;
    }
    
}

#pragma mark- Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.viewBg.frame = self.bounds;
    self.viewRecording.frame = self.bounds;
    self.viewCancle.frame = self.bounds;
    self.viewCount.frame = self.bounds;
}

#pragma mark- Data

- (void)dataConfig {
    
}

#pragma mark- Public
- (void)updateUIWithRecordState:(VoiceRecordState)state {
    
    _state = state;
    
    if (state == VoiceRecordStateNoraml || state == VoiceRecordStateCanceled || state == VoiceRecordStateFinished) {
        self.viewRecording.hidden = YES;
        self.viewCancle.hidden = YES;
        self.viewCount.hidden = YES;
    }
    else if (state == VoiceRecordStateStart) {
        self.viewRecording.hidden = NO;
        self.viewCancle.hidden = YES;
        self.viewCount.hidden = YES;
    }
    else if (state == VoiceRecordStateTouchUpCancel) {
        self.viewRecording.hidden = YES;
        self.viewCancle.hidden = NO;
        self.viewCount.hidden = YES;
    }
    else if (state == VoiceRecordStateTouchUpCounting) {
        self.viewRecording.hidden = YES;
        self.viewCancle.hidden = YES;
        self.viewCount.hidden = NO;
    }
    else if (state == VoiceRecordStateTooShort) {
        self.viewRecording.hidden = YES;
        self.viewCancle.hidden = YES;
        self.viewCount.hidden = YES;
    }
}

- (void)updateRecordingPower:(float)power {
    [self.viewRecording updateWithPower:power];
}

- (void)updateCountingRemainTime:(float)remainTime {
    [self.viewCount updateWithRemainTime:remainTime];
}

@end
