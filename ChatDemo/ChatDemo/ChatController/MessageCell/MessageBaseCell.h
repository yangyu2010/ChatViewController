//
//  MessageBaseCell.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  聊天 cell 基本的ui控制

#import <UIKit/UIKit.h>

@class MessageModel, MJBubbleView;


@interface MessageBaseCell : UITableViewCell

/********************界面控件********************/

/// 头像
@property (nonatomic, strong) UIImageView *imgVIcon;
/// 内容+背景View
@property (nonatomic, strong) MJBubbleView *viewBubble;
/// 状态按钮, 主要是消息失败时使用
@property (nonatomic, strong) UIButton *btnStatus;
/// 发送中ing 菊花
@property (nonatomic, strong) UIActivityIndicatorView *viewActivity;



/********************初始化方法********************/

/// 初始化方法, 需要传个model来, 根据消息类型和发送接收方还处理
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(MessageModel *)message;
/// model 监听set方法
@property (nonatomic, strong) MessageModel *model;



/********************Public********************/

/// 配置UI
- (void)viewConfig;
/// 配置数据等
- (void)dataConfig;


@end
