//
//  VoiceRecordController.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/2.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoiceRecordHeader.h"

@interface VoiceRecordController : NSObject

- (void)updateUIWithRecordState:(VoiceRecordState)state;

- (void)updateRecordingPower:(float)power;

- (void)updateCountingRemainTime:(float)remainTime;

- (void)showToast:(NSString *)message;

@end
