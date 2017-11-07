//
//  MJBubbleView+Image.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/7.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MJBubbleView+Image.h"
#import "MessageCellHeader.h"

@implementation MJBubbleView (Image)

/// 设置ui界面
- (void)setupImageBubbleView {
    
    self.imgView = [[UIImageView alloc] init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imgView.backgroundColor = [UIColor clearColor];
    [self.imgViewBackground addSubview:self.imgView];
}


/// 更新frame
- (void)updateImageBubbleViewFrame {
    
    if (self.imgView == nil) {
        return ;
    }
    
    if (self.isSender) {
        self.imgView.frame = CGRectMake(kMessageCellPadding, kMessageCellPadding, self.bounds.size.width - 3 * kMessageCellPadding, self.bounds.size.height - 2 * kMessageCellPadding);
    } else {
        self.imgView.frame = CGRectMake(kMessageCellPadding * 2, kMessageCellPadding, self.bounds.size.width - 3 * kMessageCellPadding, self.bounds.size.height - 2 * kMessageCellPadding);
    }
}

@end
