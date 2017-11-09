//
//  MessageCell.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/9.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  聊天的cell 主要用来处理数据 继承MessageBaseCell

#import "MessageBaseCell.h"

@interface MessageCell : MessageBaseCell




/// 不同的cell对应不同的id, 该方法就是获取model对应的id
+ (NSString *)cellIdentifierWithModel:(MessageModel *)model;

/// 获取cell的高度
+ (CGFloat)cellHeightWithModel:(MessageModel *)model;

@end
