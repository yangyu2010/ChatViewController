//
//  VoiceRecordButton.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceRecordHeader.h"

@interface VoiceRecordButton : UIButton

+ (VoiceRecordButton *)creatVoiceButton;

- (void)updateRecordBuutonStyle:(VoiceRecordState)state;

@end
