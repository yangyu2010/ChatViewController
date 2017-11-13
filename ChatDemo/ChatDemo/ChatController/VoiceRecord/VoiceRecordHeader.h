//
//  VoiceRecordHeader.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#ifndef VoiceRecordHeader_h
#define VoiceRecordHeader_h

typedef NS_ENUM(NSUInteger, VoiceRecordState) {
    VoiceRecordStateNoraml,            ///< 初始状态
    VoiceRecordStateStart,             ///< 正在录音
    VoiceRecordStateTouchUpCancel,     ///< 上滑取消（也在录音状态，UI显示有区别）
    VoiceRecordStateTouchUpCounting,   ///< 最后倒计时（也在录音状态，UI显示有区别）
    VoiceRecordStateFinished,          ///< 录音完成
    VoiceRecordStateCanceled,          ///< 确定取消了
    VoiceRecordStateTooShort,          ///< 录音时间太短（录音结束了）
};


#endif /* VoiceRecordHeader_h */
