//
//  VoiceRecordButton.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "VoiceRecordButton.h"
#import "UIColor+Utils.h"
#import "UIImage+Category.h"

@implementation VoiceRecordButton

+ (VoiceRecordButton *)creatVoiceButton {
    
    VoiceRecordButton *btn = [VoiceRecordButton buttonWithType:UIButtonTypeSystem];
    
    [btn setTitle:@"Hold to talk" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorFromHexRGB:@"565656"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorFromHexRGB:@"565656"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorFromHexRGB:@"A3A5AB"].CGColor;
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    
    return btn;
}


#pragma mark- Public
- (void)updateRecordBuutonStyle:(VoiceRecordState)state {
    
    NSLog(@"state %ld", self.state);
    
    if (state == VoiceRecordStateNoraml) {
        [self setTitle:@"Hold to talk" forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        return ;
    }
    
    else if (state == VoiceRecordStateRecording) {
        [self setTitle:@"Release to send" forState:UIControlStateNormal];
    }
    else if (state == VoiceRecordStateReleaseToCancel) {
        [self setTitle:@"Hold to talk" forState:UIControlStateNormal];
    }
    else if (state == VoiceRecordStateRecordCounting) {
        [self setTitle:@"Release to send" forState:UIControlStateNormal];
    }
    
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexRGB:@"C6C7CA"]] forState:UIControlStateNormal];
    
}

@end
