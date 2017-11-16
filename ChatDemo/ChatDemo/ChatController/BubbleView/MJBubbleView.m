//
//  MJBubbleView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MJBubbleView.h"
#import "MJBubbleView+Text.h"
#import "MJBubbleView+Image.h"
#import "MJBubbleView+Voice.h"

@implementation MJBubbleView

- (instancetype)initWithIsSender:(BOOL)isSender {
    self = [super init];
    if (self) {
        _isSender = isSender;
        
        [self dataConfig];
        [self viewConfig];
        
    }
    return self;
}

#pragma mark- Data
- (void)dataConfig {
    
    self.imgViewBackground.userInteractionEnabled = YES;
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark- UI
- (void)viewConfig {
    [self addSubview:self.imgViewBackground];
    
    // weChatBubble_Receiving_Solid 接收
    // weChatBubble_Sending_Solid 发送
    
    if (_isSender) {
        self.imgViewBackground.image = [UIImage imageNamed:@"weChatBubble_Sending_Solid"];
    } else {
        self.imgViewBackground.image = [UIImage imageNamed:@"weChatBubble_Receiving_Solid"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgViewBackground.frame = self.bounds;
    
}


#pragma mark- Get
- (UIImageView *)imgViewBackground {
    if (_imgViewBackground == nil) {
        _imgViewBackground = [[UIImageView alloc] init];
        _imgViewBackground.translatesAutoresizingMaskIntoConstraints = NO;
        _imgViewBackground.backgroundColor = [UIColor clearColor];
    }
    return _imgViewBackground;
}

#pragma mark- Public

/// 根据type来设置view
- (void)setupBubbleViewWith:(EMMessageBodyType)type {
    
    self.type = type;
    
    switch (type) {
        case EMMessageBodyTypeText: {
            [self setupTextBubbleView];
        }
            break;
        case EMMessageBodyTypeImage: {
            [self setupImageBubbleView];
        }
            break;
        case EMMessageBodyTypeVoice: {
            [self setupVoiceBubbleView];
        }
            break;
        default:
            break;
    }
}

/// 更新frame
- (void)updateSubViewFrames {

    switch (self.type) {
        case EMMessageBodyTypeText:
            [self updateTextBubbleViewFrame];
            break;
        case EMMessageBodyTypeImage:
            [self updateImageBubbleViewFrame];
            break;
        case EMMessageBodyTypeVoice:
            [self updateVoiceBubbleViewFrame];
            break;
        default:
            break;
    }
}

/// 设置发送方的
- (void)setMessageStatus:(EMMessageStatus)messageStatus {
    _messageStatus = messageStatus;
    
    if (_messageStatus == EMMessageStatusSucceed) {
        self.lblVoiceDuration.hidden = NO;
    } else {
        self.lblVoiceDuration.hidden = YES;
    }
}

@end
