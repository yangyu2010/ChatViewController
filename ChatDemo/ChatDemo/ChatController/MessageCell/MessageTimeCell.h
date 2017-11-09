//
//  MessageTimeCell.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/9.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  聊天的 时间 cell

#import <UIKit/UIKit.h>

@interface MessageTimeCell : UITableViewCell

/// 显示的时间
@property (nonatomic, copy) NSString *strTime;

/// 时间cell的标识
+ (NSString *)cellIdentifier;

/// 获取cell的高度
+ (CGFloat)cellHeight;

@end
