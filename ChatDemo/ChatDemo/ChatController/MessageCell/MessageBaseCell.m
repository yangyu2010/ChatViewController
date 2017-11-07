//
//  MessageBaseCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageBaseCell.h"
#import "MJBubbleView.h"
#import "MJBubbleView+Text.h"
#import "MessageModel.h"
#import "MessageCellHeader.h"

@interface MessageBaseCell ()
{
    /// 消息类型
    EMMessageBodyType _modelMessageType;
    
    /// 是否是发送方
    BOOL _isSender;
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
                        model:(MessageModel *)message {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _modelMessageType = message.bodyType;
        _isSender = message.isSender;
        
        [self viewConfig];
        [self dataConfig];
        
    }
    return self;
}



#pragma mark- UI

- (void)viewConfig {
    [self.contentView addSubview:self.imgVIcon];
    [self.contentView addSubview:self.viewBubble];
    [self.contentView addSubview:self.lblTime];
    [self.contentView addSubview:self.btnStatus];
    [self.contentView addSubview:self.viewActivity];
    
    
    switch (_modelMessageType) {
        case EMMessageBodyTypeText: {
            [self.viewBubble setupTextBubbleView];
        }
            break;
            
        default:
            break;
    }
    
    /// 假数据
    self.lblTime.text = @"12:12:01";
    self.imgVIcon.image = [UIImage imageNamed:@"friendsCellBack"];

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.lblTime.frame = CGRectMake(0, 0, kMessageCellTimeLabelW, kMessageCellTimeLabelH);
    self.lblTime.center = CGPointMake(self.bounds.size.width * 0.5, kMessageCellTimeLabelH * 0.5);

    if (_isSender) {
        
        self.imgVIcon.frame = CGRectMake(self.bounds.size.width - kMessageCellPadding - kMessageCellIconWh, CGRectGetMaxY(self.lblTime.frame) + kMessageCellPadding, kMessageCellIconWh, kMessageCellIconWh);
        
        self.viewBubble.frame = CGRectMake(CGRectGetMinX(self.imgVIcon.frame) - kMessageCellPadding - 200, CGRectGetMinY(self.imgVIcon.frame), 200, 200);
        
        self.btnStatus.frame = CGRectMake(CGRectGetMinX(self.viewBubble.frame) - kMessageCellPadding - kMessageCellBtnStatusWH, CGRectGetMidY(self.viewBubble.frame) - kMessageCellBtnStatusWH * 0.5, kMessageCellBtnStatusWH, kMessageCellBtnStatusWH);

    } else {
        self.imgVIcon.frame = CGRectMake(kMessageCellPadding, CGRectGetMaxY(self.lblTime.frame) + kMessageCellPadding, kMessageCellIconWh, kMessageCellIconWh);
        
        self.viewBubble.frame = CGRectMake(CGRectGetMaxX(self.imgVIcon.frame) + kMessageCellPadding, CGRectGetMinY(self.imgVIcon.frame), 200, 200);
        
        //    self.viewActivity.frame = CGRectMake(CGRectGetMaxX(self.viewBubble.frame) + kMessageCellPadding, CGRectGetMidY(self.viewBubble.frame), kMessageCellActivityViewWH, kMessageCellActivityViewWH);
        
        self.btnStatus.frame = CGRectMake(CGRectGetMaxX(self.viewBubble.frame) + kMessageCellPadding, CGRectGetMidY(self.viewBubble.frame) - kMessageCellBtnStatusWH * 0.5, kMessageCellBtnStatusWH, kMessageCellBtnStatusWH);
    }
    
    [self.viewBubble updateTextBubbleViewFrameIsSender:_isSender];
}

#pragma mark- Data

- (void)dataConfig {
    
}

#pragma mark- Action

/// 点击消息状态按钮, 一般就是发送失败时, 会点击然后重发
- (void)actionBtnStatus {
    
}

#pragma mark- Set
- (void)setModel:(MessageModel *)model {
    
    _model = model;
    
    switch (_modelMessageType) {
        case EMMessageBodyTypeText: {
            self.viewBubble.lblText.text = model.text;
        }
            break;
            
        default:
            break;
    }
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
        _viewBubble = [[MJBubbleView alloc] initWithIsSender:_isSender];
    }
    return _viewBubble;
}

/// 时间label
- (UILabel *)lblTime {
    if (_lblTime == nil) {
        _lblTime = [[UILabel alloc] init];
        _lblTime.textColor = [UIColor whiteColor];
        _lblTime.font = [UIFont systemFontOfSize:12.0f];
        _lblTime.backgroundColor = [UIColor lightGrayColor];
        _lblTime.textAlignment = NSTextAlignmentCenter;
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
//        _btnStatus.hidden = YES;
    }
    return _btnStatus;
}

/// 菊花
- (UIActivityIndicatorView *)viewActivity {
    if (_viewActivity == nil) {
        _viewActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _viewActivity.translatesAutoresizingMaskIntoConstraints = NO;
        _viewActivity.backgroundColor = [UIColor redColor];
        _viewActivity.hidden = YES;
    }
    return _viewActivity;
}


#pragma mark- Public
/// 不同的cell对应不同的id, 该方法就是获取model对应的id
+ (NSString *)cellIdentifierWithModel:(MessageModel *)model {
    NSString *cellIdentifier = @"";
    if (model.isSender) {
        switch (model.bodyType) {
            case EMMessageBodyTypeText:
                cellIdentifier = kMessageCellIdentifierSendText;
                break;
            case EMMessageBodyTypeImage:
                cellIdentifier = kMessageCellIdentifierSendImage;
                break;
            case EMMessageBodyTypeVideo:
                cellIdentifier = kMessageCellIdentifierSendVideo;
                break;
            case EMMessageBodyTypeVoice:
                cellIdentifier = kMessageCellIdentifierSendVoice;
                break;
            default:
                break;
        }
    }
    else {
        switch (model.bodyType) {
            case EMMessageBodyTypeText:
                cellIdentifier = kMessageCellIdentifierRecvText;
                break;
            case EMMessageBodyTypeImage:
                cellIdentifier = kMessageCellIdentifierRecvImage;
                break;
            case EMMessageBodyTypeVideo:
                cellIdentifier = kMessageCellIdentifierRecvVideo;
                break;
            case EMMessageBodyTypeVoice:
                cellIdentifier = kMessageCellIdentifierRecvVoice;
                break;
            default:
                break;
        }
    }

    return cellIdentifier;
}

/// 获取cell的高度
+ (CGFloat)cellHeightWithModel:(MessageModel *)model {
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    return 0;
}

@end
