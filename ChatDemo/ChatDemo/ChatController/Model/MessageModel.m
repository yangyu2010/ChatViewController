//
//  MessageModel.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


- (instancetype)initWithMessage:(EMMessage *)message {
    self = [super init];
    if (self) {
        
        _cellHeight = -1;
        _message = message;
        _firstMessageBody = message.body;
        _from = message.from;
        _isSender = (message.direction == EMMessageDirectionSend);

        switch (_firstMessageBody.type) {
            case EMMessageBodyTypeText:
            {
                EMTextMessageBody *textBody = (EMTextMessageBody *)_firstMessageBody;
                _text = textBody.text;
            }
                break;
                
            default:
                break;
        }
        
        
    }
    return self;
}

@end
