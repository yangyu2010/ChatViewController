//
//  MessageReadManager.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/10.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MessageReadManager : NSObject

+ (instancetype)defaultManager;


/**
 判断语音消息是否可以播放,
 若传入的语音消息正在播放, 停止播放并重置isMediaPlaying, 返回NO
 否则当前语音消息isMediaPlaying设为yes, 记录的上一条语音消息isMediaPlaying重置, 更新消息ext, 返回yes

 @param messageModel 判断对应的model
 @param updateCompletion 完成回调
 @return 是否可以播放
 */
- (BOOL)prepareMessageAudioModel:(MessageModel *)messageModel
            updateViewCompletion:(void (^)(MessageModel *prevAudioModel, MessageModel *currentAudioModel))updateCompletion;

@end
