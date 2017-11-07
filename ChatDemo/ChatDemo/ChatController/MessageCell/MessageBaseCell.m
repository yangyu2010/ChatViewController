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

/// 时间label
//@property (nonatomic, strong) UILabel *lblTime;

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

    } else {
        self.imgVIcon.frame = CGRectMake(kMessageCellPadding, 0, kMessageCellIconWh, kMessageCellIconWh);
        
        self.viewBubble.frame = CGRectMake(CGRectGetMaxX(self.imgVIcon.frame) + kMessageCellPadding, CGRectGetMinY(self.imgVIcon.frame), bubbleViewWidth, self.bounds.size.height - kMessageCellPadding);
        
        self.btnStatus.frame = CGRectMake(CGRectGetMaxX(self.viewBubble.frame) + kMessageCellPadding, CGRectGetMidY(self.viewBubble.frame) - kMessageCellBtnStatusWH * 0.5, kMessageCellBtnStatusWH, kMessageCellBtnStatusWH);
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

///// 时间label
//- (UILabel *)lblTime {
//    if (_lblTime == nil) {
//        _lblTime = [[UILabel alloc] init];
//        _lblTime.textColor = [UIColor whiteColor];
//        _lblTime.font = [UIFont systemFontOfSize:12.0f];
//        _lblTime.backgroundColor = [UIColor lightGrayColor];
//        _lblTime.textAlignment = NSTextAlignmentCenter;
//    }
//    return _lblTime;
//}

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
    
    /// 缓存用 如果当前model已经有值了, 直接return
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    /// 计算bubbleView里 """文本""" 最大的宽度, 这里用屏幕的宽度 - 2个(头像和2倍的间距) - 左边或者右边的一个间距(气泡距离头像的距离) - 文本在气泡里面的大小(一边有1个间距, 另一边有2个间距)
    //CGFloat bubbleMaxWidth = [UIScreen mainScreen].bounds.size.width - 2 * (kMessageCellIconWh + kMessageCellPadding * 2) - kMessageCellPadding - 3 * kMessageCellBubbleMargin;
    
    CGFloat bubbleMaxWidth = kMessageCellBubbleContentMaxWidth;
    
    /// 高度
    CGFloat height = 0;
    
    /// 根据类型来判断当前bubble view的 宽高度
    switch (model.bodyType) {
        case EMMessageBodyTypeText: {
            
            /// 计算出当前文字所需要的宽高度
            CGRect rect = [model.text boundingRectWithSize:CGSizeMake(bubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kMessageCellTextFontSize]} context:nil];

            /// 文本在bubbleView里上下各有 1 个 间距
            CGFloat bubbleViewHeight = rect.size.height + 2 * kMessageCellPadding;
            
            /// 判断最低高度 == 头像的高度
            height += (bubbleViewHeight > kMessageCellIconWh ? bubbleViewHeight : kMessageCellIconWh);
            
            /// 气泡的宽度需要加 左右 的间距(一边有10px, 另一边有20px)
            model.bubbleViewWidth = rect.size.width + 30;
        }
            break;
        case EMMessageBodyTypeImage: {
            
            height = model.thumbnailImageSize.height;
            model.bubbleViewWidth = model.thumbnailImageSize.width + 30;
        }
            break;
        default:
            break;
    }
    
    
    /// 每个气泡距离 cell 底部 都有 10个px
    height += kMessageCellPadding;
    
    /// 赋值给model, 复用
    model.cellHeight = height;

    return height;
}

@end
