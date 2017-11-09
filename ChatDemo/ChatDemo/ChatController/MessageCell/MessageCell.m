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


@implementation MessageCell

#pragma mark- Rewrite
- (void)setModel:(MessageModel *)model {
    [super setModel:model];
    
    if (!model.isSender) {
        return ;
    }
    
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
    
    /// 根据类型来判断当前bubble view的 宽高度
    switch (model.bodyType) {
            
            /***************文本***************/
            
        case EMMessageBodyTypeText: {
            
            /// 计算出当前文字所需要的宽高度
            CGRect rect = [model.text boundingRectWithSize:CGSizeMake(bubbleContentMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kMessageCellTextFontSize]} context:nil];
            
            /// 文本在bubbleView里上下各有 1 个 间距
            CGFloat bubbleViewHeight = rect.size.height + 2 * kMessageCellPadding;
            
            /// 判断最低高度 == 头像的高度
            height += (bubbleViewHeight > kMessageCellIconWh ? bubbleViewHeight : kMessageCellIconWh);
            
            /// 气泡的宽度需要加 左右 的间距(一边有10px, 另一边有20px)
            model.bubbleViewWidth = rect.size.width + 30;
        }
            break;
            
            /***************图片***************/
            
        case EMMessageBodyTypeImage: {
            
            height = model.thumbnailImageSize.height;
            model.bubbleViewWidth = model.thumbnailImageSize.width + 30;
        }
            break;
            
            /***************语音***************/
            
        case EMMessageBodyTypeVoice: {
            height += kMessageCellIconWh;
            model.bubbleViewWidth = kMessageCellVoiceMinWidth + model.mediaDuration / 60 * kMessageCellVoicePadding;
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
