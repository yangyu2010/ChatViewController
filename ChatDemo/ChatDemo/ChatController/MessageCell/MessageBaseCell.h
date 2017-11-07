//
//  MessageBaseCell.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;


@interface MessageBaseCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(MessageModel *)message;

/// model 监听set方法 
@property (nonatomic, strong) MessageModel *model;

/// 更新bubble view 宽度
- (void)updateBubbleViewWidth;

/// 不同的cell对应不同的id, 该方法就是获取model对应的id
+ (NSString *)cellIdentifierWithModel:(MessageModel *)model;

/// 获取cell的高度
+ (CGFloat)cellHeightWithModel:(MessageModel *)model;

@end
