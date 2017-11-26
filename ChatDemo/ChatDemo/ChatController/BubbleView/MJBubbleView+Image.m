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
    self.imgView.clipsToBounds = YES;
    [self.imgViewBackground addSubview:self.imgView];
}


/// 更新frame
- (void)updateImageBubbleViewFrame {
    
    if (self.imgView == nil) {
        return ;
    }
    
    if (self.isSender) {
        self.imgView.frame = CGRectMake(kMessageCellBubbleMargin, kMessageCellBubbleMargin, self.bounds.size.width - 3 * kMessageCellBubbleMargin + 2, self.bounds.size.height - 2 * kMessageCellBubbleMargin);
    } else {
        self.imgView.frame = CGRectMake(kMessageCellBubbleMargin * 2 - 2, kMessageCellBubbleMargin, self.bounds.size.width - 3 * kMessageCellBubbleMargin + 2, self.bounds.size.height - 2 * kMessageCellBubbleMargin);
    }
}

@end
