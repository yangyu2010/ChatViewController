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
    VoiceRecordStateNoraml,                ///< 初始状态
    VoiceRecordStateStart,            ///< 正在录音
    VoiceRecordStateCancel,      ///< 上滑取消（也在录音状态，UI显示有区别）
    VoiceRecordStateCounting,       ///< 最后10s倒计时（也在录音状态，UI显示有区别）
    VoiceRecordStateTooShort,       ///< 录音时间太短（录音结束了）
}; 


#endif /* VoiceRecordHeader_h */
