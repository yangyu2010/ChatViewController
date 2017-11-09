//
//  MessageBaseCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageBaseCell.h"
#import "MJBubbleView.h"
#import "MessageModel.h"
#import "MessageCellHeader.h"
#import "UIColor+Utils.h"
#import "UIView+Sugar.h"
#import <UIImageView+WebCache.h>


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
    
    self.layer.drawsAsynchronously = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.contentView.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    
    [self.contentView addSubview:self.imgVIcon];
    [self.contentView addSubview:self.viewBubble];
    [self.contentView addSubview:self.btnStatus];
    [self.contentView addSubview:self.viewActivity];
    
    [self.viewBubble setupBubbleViewWith:_modelMessageType];
    
    
    /// 假数据
    self.imgVIcon.image = [UIImage imageNamed:@"friendsCellBack"];

}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat bubbleViewWidth = self.model.bubbleViewWidth;
    
    if (_isSender) {
        
        self.imgVIcon.frame = CGRectMake(self.bounds.size.width - kMessageCellPadding - kMessageCellIconWh, 0, kMessageCellIconWh, kMessageCellIconWh);
        
        self.viewBubble.frame = CGRectMake(CGRectGetMinX(self.imgVIcon.frame) - kMessageCellPadding - bubbleViewWidth, CGRectGetMinY(self.imgVIcon.frame), bubbleViewWidth, self.bounds.size.height - kMessageCellPadding);
        
        self.btnStatus.frame = CGRectMake(CGRectGetMinX(self.viewBubble.frame) - kMessageCellPadding - kMessageCellBtnStatusWH, CGRectGetMidY(self.viewBubble.frame) - kMessageCellBtnStatusWH * 0.5, kMessageCellBtnStatusWH, kMessageCellBtnStatusWH);
        
        self.viewActivity.frame = self.btnStatus.frame;

    } else {
        self.imgVIcon.frame = CGRectMake(kMessageCellPadding, 0, kMessageCellIconWh, kMessageCellIconWh);
        
        self.viewBubble.frame = CGRectMake(CGRectGetMaxX(self.imgVIcon.frame) + kMessageCellPadding, CGRectGetMinY(self.imgVIcon.frame), bubbleViewWidth, self.bounds.size.height - kMessageCellPadding);
        
        self.btnStatus.frame = CGRectMake(CGRectGetMaxX(self.viewBubble.frame) + kMessageCellPadding, CGRectGetMidY(self.viewBubble.frame) - kMessageCellBtnStatusWH * 0.5, kMessageCellBtnStatusWH, kMessageCellBtnStatusWH);
        
        self.viewActivity.frame = self.btnStatus.frame;

    }
    
    [self.viewBubble updateSubViewFrames];
    
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
        case EMMessageBodyTypeImage: {
            self.viewBubble.imgView.image = model.thumbnailImage;
            UIImage *image = model.thumbnailImage;
            if (!image) {
                image = model.image;
                if (!image) {
                    [self.viewBubble.imgView sd_setImageWithURL:[NSURL URLWithString:_model.fileURLPath] placeholderImage:[UIImage imageNamed:_model.failImageName]];
                } else {
                    self.viewBubble.imgView.image = image;
                }
            } else {
                self.viewBubble.imgView.image = image;
            }
        }
            break;
        case EMMessageBodyTypeVoice: {
            self.viewBubble.lblVoiceDuration.text = [NSString stringWithFormat:@"%d''",(int)model.mediaDuration];
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
        _imgVIcon.contentMode = UIViewContentModeScaleToFill;
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
