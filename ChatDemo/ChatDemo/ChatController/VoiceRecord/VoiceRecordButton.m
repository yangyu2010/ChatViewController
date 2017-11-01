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
    
    [btn setTitle:@"按住 说话" forState:UIControlStateNormal];
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
        [self setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        return ;
    }
    
    else if (state == VoiceRecordStateStart) {
        [self setTitle:@"松开 结束" forState:UIControlStateNormal];
    }
    else if (state == VoiceRecordStateCancel) {
        [self setTitle:@"松开 取消" forState:UIControlStateNormal];
    }
    else if (state == VoiceRecordStateCounting) {
        [self setTitle:@"松开 结束" forState:UIControlStateNormal];
    }
    
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHexRGB:@"C6C7CA"]] forState:UIControlStateNormal];
    
}

@end
