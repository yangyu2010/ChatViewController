//
//  MessageBaseCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageBaseCell.h"
#import "MJBubbleView.h"
#import <Hyphenate/Hyphenate.h>

@interface MessageBaseCell ()
{
    /// 当前cell的消息
    EMMessage *_message;
    
    /// 当前消息是接受的, 还是发送的
    BOOL _isMessageReceive;
}

/// 头像
@property (nonatomic, strong) UIImageView *imgVIcon;

/// 内容+背景View
@property (nonatomic, strong) MJBubbleView *viewBubble;

/// 时间label
@property (nonatomic, strong) UILabel *lblTime;

/// 状态按钮, 主要是消息失败时使用
@property (nonatomic, strong) UIButton *btnStatus;

/// 发送中ing 菊花
@property (nonatomic, strong) UIActivityIndicatorView *viewActivity;


@end

@implementation MessageBaseCell

#pragma mark- Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                        model:(EMMessage *)message {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self viewConfig];
        [self dataConfig];
        _message = message;
        _isMessageReceive = (_message.direction == EMMessageDirectionReceive);
    }
    return self;
}



#pragma mark- UI

- (void)viewConfig {
    [self.contentView addSubview:self.imgVIcon];
    [self.contentView addSubview:self.viewBubble];
    [self.contentView addSubview:self.btnStatus];
    [self.contentView addSubview:self.viewActivity];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lblTime.frame = CGRectMake(self.bounds.size.width * 0.5, 0, 100, 20);
    if (_isMessageReceive) {
//        self.imgVIcon.frame = CGRectMake(<#CGFloat x#>, CGRectGetMaxX(self.lblTime.frame) + 10, <#CGFloat width#>, <#CGFloat height#>)
    }
}

#pragma mark- Data

- (void)dataConfig {
    
}

#pragma mark- Action

/// 点击消息状态按钮, 一般就是发送失败时, 会点击然后重发
- (void)actionBtnStatus {
    
}


#pragma mark- Get

/// 头像
- (UIImageView *)imgVIcon {
    if (_imgVIcon == nil) {
        _imgVIcon = [[UIImageView alloc] init];
        _imgVIcon.translatesAutoresizingMaskIntoConstraints = NO;
        _imgVIcon.backgroundColor = [UIColor clearColor];
        _imgVIcon.clipsToBounds = YES;
        _imgVIcon.userInteractionEnabled = YES;
    }
    return _imgVIcon;
}

/// 内容+背景View
- (MJBubbleView *)viewBubble {
    if (_viewBubble == nil) {
        _viewBubble = [[MJBubbleView alloc] init];
    }
    return _viewBubble;
}

/// 时间label
- (UILabel *)lblTime {
    if (_lblTime == nil) {
        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = [UIColor whiteColor];
        _lblTime.font = [UIFont systemFontOfSize:12.0f];
        
    }
    return _lblTime;
}

/// 状态按钮
- (UIButton *)btnStatus {
    if (_btnStatus == nil) {
        _btnStatus = [UIButton buttonWithType:UIButtonTypeCustom];  //@"MessageSendFail"
        _btnStatus.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_btnStatus setImage:[UIImage imageNamed:@"MessageSendFail"] forState:UIControlStateNormal];
        [_btnStatus setImage:[UIImage imageNamed:@"MessageSendFail_HL"] forState:UIControlStateHighlighted];
        [_btnStatus addTarget:self action:@selector(actionBtnStatus) forControlEvents:UIControlEventTouchUpInside];
        _btnStatus.hidden = YES;
    }
    return _btnStatus;
}

/// 菊花
- (UIActivityIndicatorView *)viewActivity {
    if (_viewActivity == nil) {
        _viewActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _viewActivity.translatesAutoresizingMaskIntoConstraints = NO;
        _viewActivity.backgroundColor = [UIColor clearColor];
        _viewActivity.hidden = YES;
    }
    return _viewActivity;
}


@end
