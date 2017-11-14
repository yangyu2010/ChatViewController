//
//  MessageCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/9.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "MessageCellHeader.h"
#import "MJBubbleView.h"


@implementation MessageCell

#pragma mark- Private

/// 点击 气泡 view
- (void)actionBubbleViewTapAction:(UITapGestureRecognizer *)tapRecognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDidSelected:model:)]) {
        [self.delegate messageCellDidSelected:self model:self.model];
    }
}

/// 点击头像
- (void)actionAvatarViewTapAction:(UITapGestureRecognizer *)tapRecognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDidSelectedAvatar:model:)]) {
        [self.delegate messageCellDidSelectedAvatar:self model:self.model];
    }
}

/// 点击状态按钮
- (void)actionBtnStatus {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageCellDidSelectedStatusButton:model:)]) {
        [self.delegate messageCellDidSelectedStatusButton:self model:self.model];
    }
}




#pragma mark- Rewrite

- (void)dataConfig {
    [super dataConfig];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionBubbleViewTapAction:)];
    [self.viewBubble addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionAvatarViewTapAction:)];
    [self.imgVIcon addGestureRecognizer:tapRecognizer2];
    
}

- (void)setModel:(MessageModel *)model {
    [super setModel:model];
    
    if (!model.isSender) {
        return ;
    }
    
    self.viewBubble.messageStatus = model.messageStatus;
    
    switch (model.messageStatus) {
        case EMMessageStatusPending:
            break;
            
        case EMMessageStatusDelivering: {
            self.btnStatus.hidden = YES;
            self.viewActivity.hidden = NO;
            [self.viewActivity startAnimating];
        }
            break;
        case EMMessageStatusSucceed: {
            self.btnStatus.hidden = YES;
            [self.viewActivity stopAnimating];
            self.viewActivity.hidden = YES;
        }
            break;
        case EMMessageStatusFailed: {
            [self.viewActivity stopAnimating];
            self.viewActivity.hidden = YES;
            self.btnStatus.hidden = NO;
        }
            break;
        default:
            break;
    }
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
    
    CGFloat bubbleContentMaxWidth = kMessageCellBubbleContentMaxWidth;
    
    /// 高度
    CGFloat height = 0;
    
    /// 最后的高度需要加上这个值
    CGFloat _cellPadding = (kMessageCellPadding + 2 * kMessageCellBubbleMargin);
    
    /// 根据类型来判断当前bubble view的 宽高度
    switch (model.bodyType) {
            
            /***************文本***************/
            
        case EMMessageBodyTypeText: {
            
            /// 计算出当前文字所需要的宽高度
            CGRect rect = [model.text boundingRectWithSize:CGSizeMake(bubbleContentMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kMessageCellTextFontSize]} context:nil];
            
            /// 文本在bubbleView里上下各有 1 个 间距
            CGFloat bubbleViewHeight = rect.size.height + _cellPadding;
            
            /// 判断最低高度 == 头像的高度
            if (bubbleViewHeight > kMessageCellIconWh) {
                height = bubbleViewHeight + kMessageCellPadding;
            } else {
                height = kMessageCellIconWh + kMessageCellPadding;
            }
            
            /// 气泡的宽度需要加 左右 的间距(一边有10px, 另一边有20px)
            model.bubbleViewWidth = rect.size.width + 30;
        }
            break;
            
            /***************图片***************/
            
        case EMMessageBodyTypeImage: {
            
            height = model.thumbnailImageSize.height + _cellPadding;
            model.bubbleViewWidth = model.thumbnailImageSize.width + _cellPadding;
        }
            break;
            
            /***************语音***************/
            
        case EMMessageBodyTypeVoice: {
            height += kMessageCellIconWh + kMessageCellPadding;
            model.bubbleViewWidth = kMessageCellVoiceMinWidth + model.mediaDuration / 60 * kMessageCellVoicePadding;
        }
            break;
        default:
            break;
    }
    
    /// 赋值给model, 复用
    model.cellHeight = height;
    
    return height;
}

@end
