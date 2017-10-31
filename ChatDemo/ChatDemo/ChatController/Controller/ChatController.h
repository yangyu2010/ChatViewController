//
//  ChatController.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Hyphenate/Hyphenate.h>

@interface ChatController : UIViewController

- (instancetype)initWithConversationChatter:(NSString *)conversationChatter
                           conversationType:(EMConversationType)conversationType;


@end
