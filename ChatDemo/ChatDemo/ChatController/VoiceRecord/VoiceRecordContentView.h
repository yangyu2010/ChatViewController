//
//  VoiceRecordContentView.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceRecordContentView : UIView

@end

/// 正在录制显示的View
@interface VoiceRecordingView : VoiceRecordContentView

- (void)updateWithPower:(float)power;

@end

/// 显示 取消 的View
@interface VoiceRecordReleaseToCancelView : VoiceRecordContentView

@end

/// 显示 倒计时 的View
@interface VoiceRecordCountingView : VoiceRecordContentView

- (void)updateWithRemainTime:(float)remainTime;

@end


/// 显示 提示语 的View
@interface VoiceRecordTipView : VoiceRecordContentView

- (void)showWithMessage:(NSString *)msg;

@end
