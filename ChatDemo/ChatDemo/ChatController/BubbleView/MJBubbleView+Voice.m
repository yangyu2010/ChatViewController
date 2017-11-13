//
//  MJBubbleView+Voice.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/8.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MJBubbleView+Voice.h"
#import "MessageCellHeader.h"

@implementation MJBubbleView (Voice)

#pragma mark- Public

/// 设置ui界面
- (void)setupVoiceBubbleView {
    
    /// 语言的那个图片
    self.imgViewVoice = [[UIImageView alloc] init];
    self.imgViewVoice.frame = CGRectZero;
    self.imgViewVoice.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgViewVoice.backgroundColor = [UIColor clearColor];
    self.imgViewVoice.animationDuration = 1;
    if (self.isSender) {
        self.imgViewVoice.image = [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    } else {
        self.imgViewVoice.image = [UIImage imageNamed:@"ReceiverVoiceNodePlaying"];
    }
    [self.imgViewBackground addSubview:self.imgViewVoice];
    
    /// 语言长度
    self.lblVoiceDuration = [[UILabel alloc] init];
    self.lblVoiceDuration.frame = CGRectZero;
    self.lblVoiceDuration.textAlignment = NSTextAlignmentLeft;
    self.lblVoiceDuration.font = [UIFont systemFontOfSize:14.0];
    self.lblVoiceDuration.textColor = [UIColor lightGrayColor];
    self.lblVoiceDuration.translatesAutoresizingMaskIntoConstraints = NO;
    self.lblVoiceDuration.backgroundColor = [UIColor clearColor];
    [self addSubview:self.lblVoiceDuration];
    
    /// 未读时显示的红点
    self.imgViewIsRead = [[UIImageView alloc] init];
    self.imgViewIsRead.frame = CGRectZero;
    self.imgViewIsRead.image = [UIImage imageNamed:@"msg_chat_voice_unread"];
    self.imgViewIsRead.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgViewIsRead.clipsToBounds = YES;
    [self addSubview:self.imgViewIsRead];
    
    if (self.isSender) {
        self.imgViewIsRead.hidden = YES;
        
        self.imgViewVoice.animationImages = @[
                                              [UIImage imageNamed:@"SenderVoiceNodePlaying001"],
                                              [UIImage imageNamed:@"SenderVoiceNodePlaying002"],
                                              [UIImage imageNamed:@"SenderVoiceNodePlaying003"]
                                              ];
    } else {
        self.imgViewIsRead.hidden = NO;
        
        self.imgViewVoice.animationImages = @[[UIImage imageNamed:@"ReceiverVoiceNodePlaying001"],
                                              [UIImage imageNamed:@"ReceiverVoiceNodePlaying002"],
                                              [UIImage imageNamed:@"ReceiverVoiceNodePlaying003"]
                                              ];
    }
}

/// 更新frame
- (void)updateVoiceBubbleViewFrame {
    
    if ((self.imgViewVoice == nil) ||
        (self.lblVoiceDuration == nil) ||
        (self.imgViewIsRead == nil)) {
        
        return ;
    }

    if (self.isSender) {

        self.imgViewVoice.frame = CGRectMake(0, 0, self.imgViewVoice.image.size.width, self.imgViewVoice.image.size.height);
        self.imgViewVoice.center = CGPointMake(self.bounds.size.width - 2 * kMessageCellBubbleMargin - self.imgViewVoice.image.size.width * 0.5, CGRectGetMidY(self.frame));

        self.lblVoiceDuration.frame = CGRectMake(-30 + kMessageCellBubbleMargin, CGRectGetMidY(self.frame), 30, 12);
        
    } else {
        
        self.imgViewVoice.frame = CGRectMake(0, 0, self.imgViewVoice.image.size.width, self.imgViewVoice.image.size.height);
        self.imgViewVoice.center = CGPointMake(2 * kMessageCellBubbleMargin + self.imgViewVoice.image.size.width * 0.5, CGRectGetMidY(self.frame));

        self.imgViewIsRead.frame = CGRectMake(self.bounds.size.width + kMessageCellBubbleMargin, 3, self.imgViewIsRead.image.size.width, self.imgViewIsRead.image.size.height);

        self.lblVoiceDuration.frame = CGRectMake(CGRectGetMinX(self.imgViewIsRead.frame), CGRectGetMidY(self.frame), 30, 12);
        
    }

}

@end
