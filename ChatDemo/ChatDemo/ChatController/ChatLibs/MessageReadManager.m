//
//  MessageReadManager.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/10.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageReadManager.h"

@interface MessageReadManager ()

@property (nonatomic, strong) MessageModel *modelAudioMessage;


@end

@implementation MessageReadManager

/// 单例
static MessageReadManager *_detailInstance = nil;
+ (instancetype)defaultManager {
    @synchronized(self){
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            _detailInstance = [[self alloc] init];
        });
    }
    return _detailInstance;
}

#pragma mark- Public
- (BOOL)prepareMessageAudioModel:(MessageModel *)messageModel
            updateViewCompletion:(void (^)(MessageModel *prevAudioModel, MessageModel *currentAudioModel))updateCompletion {
    
    BOOL isPrepare = NO;
    
    if (messageModel.bodyType != EMMessageBodyTypeVoice) {
        return isPrepare;
    }
    
    MessageModel *prevAudioModel = self.modelAudioMessage;
    MessageModel *currentAudioModel = messageModel;
    self.modelAudioMessage = messageModel;
    
    if (currentAudioModel.isMediaPlaying) {
        /// 正在播放的情况, 点击了就去暂停
        messageModel.isMediaPlaying = NO;
        self.modelAudioMessage = nil;
        currentAudioModel = nil;
        
        /// 暂停播放操作
        
    } else {
        /// 设置当前在播放
        messageModel.isMediaPlaying = YES;
        /// 把上一个播放的暂停了, 有可能它正在播放
        prevAudioModel.isMediaPlaying = NO;
        
        isPrepare = YES;
        
        /// 没有播放过, 需要处理
        if (!messageModel.isMediaPlayed) {
            messageModel.isMediaPlayed = YES;
            EMMessage *chatMessage = messageModel.message;
            if (chatMessage.ext) {
                NSMutableDictionary *dict = [chatMessage.ext mutableCopy];
                if (![[dict objectForKey:@"isPlayed"] boolValue]) {
                    [dict setObject:@YES forKey:@"isPlayed"];
                    chatMessage.ext = dict;
                    [[EMClient sharedClient].chatManager updateMessage:chatMessage completion:nil];
                }
            } else {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:chatMessage.ext];
                [dic setObject:@YES forKey:@"isPlayed"];
                chatMessage.ext = dic;
                [[EMClient sharedClient].chatManager updateMessage:chatMessage completion:nil];
            }
        }
        
    }
    
    if (updateCompletion) {
        updateCompletion(prevAudioModel, currentAudioModel);
    }
    
    return isPrepare;
}

@end
