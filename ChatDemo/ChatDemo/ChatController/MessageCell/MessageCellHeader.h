//
//  MessageCellHeader.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/7.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#ifndef MessageCellHeader_h
#define MessageCellHeader_h

/// cell 里面view间距
#define kMessageCellPadding         10.0f

/// cell bubble里间距
#define kMessageCellBubbleMargin    8.0f

/// cell 头像的宽高
#define kMessageCellIconWh          44.0f

/// cell 时间label宽度
#define kMessageCellTimeLabelW      100.0f

/// cell 时间label高度
#define kMessageCellTimeLabelH      20.0f

/// cell 菊花大小
#define kMessageCellActivityViewWH  10.0f

/// cell 状态按钮大小
#define kMessageCellBtnStatusWH     24.0f

/// cell 文本大小
#define kMessageCellTextFontSize    16.0f

/// cell 里 气泡view最大的宽度, (屏幕的宽度 - 2个(头像和2个的间距))
#define KMessageCellBubbleViewMaxWidth ([UIScreen mainScreen].bounds.size.width - 2 * (kMessageCellIconWh + kMessageCellPadding * 2))

/// 计算bubbleView里 "内容(文本或图片或别的)" 最大的宽度, 气泡view最大的宽度 - 左边或者右边的一个间距(气泡距离气泡的距离) - 文本在气泡里面的大小(一边有1个间距, 另一边有2个间距)
#define kMessageCellBubbleContentMaxWidth (KMessageCellBubbleViewMaxWidth - kMessageCellPadding - 3 * kMessageCellBubbleMargin)

/// 语言长度 最大
#define kMessageCellVoiceMaxWidth (KMessageCellBubbleViewMaxWidth * 0.75)

/// 语言长度 最小
#define kMessageCellVoiceMinWidth (KMessageCellBubbleViewMaxWidth * 0.25)

/// 语言长度的差距, 用时长乘这个差距
#define kMessageCellVoicePadding (kMessageCellVoiceMaxWidth - kMessageCellVoiceMinWidth)

#define kMessageCellIdentifierRecvText      @"kMessageCellIdentifierRecvText"
#define kMessageCellIdentifierRecvVoice     @"kMessageCellIdentifierRecvVoice"
#define kMessageCellIdentifierRecvVideo     @"kMessageCellIdentifierRecvVideo"
#define kMessageCellIdentifierRecvImage     @"kMessageCellIdentifierRecvImage"

#define kMessageCellIdentifierSendText      @"kMessageCellIdentifierSendText"
#define kMessageCellIdentifierSendVoice     @"kMessageCellIdentifierSendVoice"
#define kMessageCellIdentifierSendVideo     @"kMessageCellIdentifierSendVideo"
#define kMessageCellIdentifierSendImage     @"kMessageCellIdentifierSendImage"


///// cell 里面view间距
//CGFloat const kMessageCellPadding = 10.0f;
///// cell 头像的宽高
//CGFloat const kMessageCellIconWh = 44.0f;
///// cell 时间label宽度
//CGFloat const kMessageCellTimeLabelW = 100.0f;
///// cell 时间label高度
//CGFloat const kMessageCellTimeLabelH = 20.0f;
///// cell 菊花大小
//CGFloat const kMessageCellActivityViewWH = 10.0f;
//// cell 状态按钮大小
//CGFloat const kMessageCellBtnStatusWH = 24.0f;
//
//
//NSString *const kMessageCellIdentifierRecvText =  @"kMessageCellIdentifierRecvText";
//NSString *const kMessageCellIdentifierRecvVoice = @"kMessageCellIdentifierRecvVoice";
//NSString *const kMessageCellIdentifierRecvVideo = @"kMessageCellIdentifierRecvVideo";
//NSString *const kMessageCellIdentifierRecvImage = @"kMessageCellIdentifierRecvImage";
//
//NSString *const kMessageCellIdentifierSendText =  @"kMessageCellIdentifierSendText";
//NSString *const kMessageCellIdentifierSendVoice = @"kMessageCellIdentifierSendVoice";
//NSString *const kMessageCellIdentifierSendVideo = @"kMessageCellIdentifierSendVideo";
//NSString *const kMessageCellIdentifierSendImage = @"kMessageCellIdentifierSendImage";


#endif /* MessageCellHeader_h */
