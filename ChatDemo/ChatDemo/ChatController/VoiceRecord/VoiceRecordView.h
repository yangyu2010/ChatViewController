//
//  VoiceRecordView.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  控制器显示的 录音 的View

#import <UIKit/UIKit.h>
#import "VoiceRecordHeader.h"

@interface VoiceRecordView : UIView

- (void)updateUIWithRecordState:(VoiceRecordState)state;

@end
