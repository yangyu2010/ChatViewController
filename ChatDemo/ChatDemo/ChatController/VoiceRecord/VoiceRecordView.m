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

/// 正在录制的View
@property (nonatomic, strong) VoiceRecordingView *viewRecording;


@end

@implementation VoiceRecordView

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
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    self.layer.cornerRadius = 6;
    
    if (self.viewRecording == nil) {
        self.viewRecording = [[VoiceRecordingView alloc] init];
        [self addSubview:self.viewRecording];
        self.viewRecording.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.viewRecording.frame = self.bounds;
}

#pragma mark- Data

- (void)dataConfig {
    
}

#pragma mark- Public
- (void)updateUIWithRecordState:(VoiceRecordState)state {
    
    if (state == VoiceRecordStateNoraml) {

        self.viewRecording.hidden = YES;
    }
    else if (state == VoiceRecordStateRecording)
    {
        self.viewRecording.hidden = NO;
    }
}

@end
