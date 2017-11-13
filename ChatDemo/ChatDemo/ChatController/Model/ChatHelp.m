//
//  ChatHelp.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/8.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatHelp.h"
#import <Hyphenate/Hyphenate.h>

@implementation ChatHelp

///  生产一个文本Message
+ (EMMessage *)getTextMessage:(NSString *)text
                            to:(NSString *)toUser {
    
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:text];
    NSString *from = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:toUser from:from to:toUser body:body ext:nil];
    message.chatType = EMChatTypeChat;
    message.status = EMMessageStatusDelivering;
    return message;
}

/// 生产一个图片Message
+ (EMMessage *)getImageMessage:(UIImage *)image
                            to:(NSString *)toUser {
    
    NSData *dataOrigin = UIImagePNGRepresentation(image);
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:dataOrigin thumbnailData:nil];
    body.compressionRatio = 1.0f;
    body.size = image.size;
    
    NSString *from = [[EMClient sharedClient] currentUsername];
    
    EMMessage *message = [[EMMessage alloc] initWithConversationID:toUser from:from to:toUser body:body ext:nil];
    message.chatType = EMChatTypeChat;
    message.status = EMMessageStatusDelivering;
    return message;
}

/// 生产一个音频Message
+ (EMMessage *)getVoiceMessageWithLocalPath:(NSString *)localPath
                                    duration:(NSInteger)duration
                                          to:(NSString *)toUser {
    
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithLocalPath:localPath displayName:@"audio"];
    body.duration = (int)duration;
    NSString *from = [[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc] initWithConversationID:toUser from:from to:toUser body:body ext:nil];
    message.chatType = EMChatTypeChat;
    
    return message;
}

@end
