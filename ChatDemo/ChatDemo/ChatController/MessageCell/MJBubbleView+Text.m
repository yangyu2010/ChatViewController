//
//  MJBubbleView+Text.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/7.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MJBubbleView+Text.h"
#import "MessageCellHeader.h"

@implementation MJBubbleView (Text)


#pragma mark- Public

/// 设置ui界面
- (void)setupTextBubbleView {
    
    self.lblText = [[UILabel alloc] init];
    self.lblText.font = [UIFont systemFontOfSize:kMessageCellTextFontSize];
    self.lblText.backgroundColor = [UIColor clearColor];
    self.lblText.numberOfLines = 0;
    [self.imgViewBackground addSubview:self.lblText];

}

/// 更新frame
- (void)updateTextBubbleViewFrame {
    if (self.lblText == nil) {
        return ;
    }
    
    if (self.isSender) {
        self.lblText.frame = CGRectMake(kMessageCellPadding, kMessageCellPadding, self.bounds.size.width - 3 * kMessageCellPadding, self.bounds.size.height - 2 * kMessageCellPadding);
    } else {
        self.lblText.frame = CGRectMake(kMessageCellPadding * 2, kMessageCellPadding, self.bounds.size.width - 3 * kMessageCellPadding, self.bounds.size.height - 2 * kMessageCellPadding);
    }
}


@end
