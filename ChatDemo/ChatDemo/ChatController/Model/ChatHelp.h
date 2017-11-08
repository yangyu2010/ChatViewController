//
//  ChatHelp.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/8.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Hyphenate/EMMessage.h>

@interface ChatHelp : NSObject

/**
 生产一个文本Message

 @param text 文本
 @param toUser 接收方
 @return EMMessage
 */
+ (EMMessage *)getTextMessage:(NSString *)text
                            to:(NSString *)toUser;



/**
 生产一个图片Message

 @param image 图片
 @param toUser 接收方
 @return EMMessage
 */
+ (EMMessage *)getImageMessage:(UIImage *)image
                            to:(NSString *)toUser;

@end
