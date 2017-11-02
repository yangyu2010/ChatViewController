//
//  VoiceRecordController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/2.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "VoiceRecordController.h"
#import "VoiceRecordView.h"
#import "VoiceRecordContentView.h"

@interface VoiceRecordController ()

@property (nonatomic, strong) VoiceRecordView *viewVoiceRecord;

@property (nonatomic, strong) VoiceRecordTipView *viewTip;

@end

@implementation VoiceRecordController

#pragma mark- Get
- (VoiceRecordView *)viewVoiceRecord {
    if (_viewVoiceRecord == nil) {
        _viewVoiceRecord = [[VoiceRecordView alloc] init];
        _viewVoiceRecord.frame = CGRectMake(0, 0, 150, 150);
        _viewVoiceRecord.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    }
    return _viewVoiceRecord;
}

- (VoiceRecordTipView *)viewTip {
    if (_viewTip == nil) {
        _viewTip = [[VoiceRecordTipView alloc] init];
        _viewTip.frame = CGRectMake(0, 0, 150, 150);
        _viewTip.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    }
    return _viewTip;
}

#pragma mark- Public
- (void)updateUIWithRecordState:(VoiceRecordState)state {
    if (state == VoiceRecordStateNoraml || state == VoiceRecordStateFinished) {
        if (self.viewVoiceRecord.superview) {
            [self.viewVoiceRecord removeFromSuperview];
        }
        return;
    }
    
    if (self.viewVoiceRecord.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.viewVoiceRecord];
    }
    
    [self.viewVoiceRecord updateUIWithRecordState:state];
}

- (void)updateRecordingPower:(float)power {
    [self.viewVoiceRecord updateRecordingPower:power];
}

- (void)updateCountingRemainTime:(float)remainTime {
    [self.viewVoiceRecord updateCountingRemainTime:remainTime];
}

- (void)showToast:(NSString *)message {
    if (self.viewTip.superview == nil) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.viewTip];
        [self.viewTip showWithMessage:message];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.viewTip removeFromSuperview];
        });
    }
}

@end
