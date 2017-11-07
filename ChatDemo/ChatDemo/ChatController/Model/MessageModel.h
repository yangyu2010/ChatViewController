//
//  MessageModel.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Hyphenate/Hyphenate.h>

@interface MessageModel : NSObject

/// 消息cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
/// 消息对象
@property (nonatomic, strong, readonly) EMMessage *message;
/// 消息体
@property (nonatomic, strong, readonly) EMMessageBody *firstMessageBody;
/// 消息id
@property (nonatomic, strong, readonly) NSString *messageId;
/// 消息体类型
@property (nonatomic, assign, readonly) EMMessageBodyType bodyType;
/// 消息发送状态
@property (nonatomic, assign, readonly) EMMessageStatus messageStatus;
/// 聊天类型
@property (nonatomic, assign, readonly) EMChatType messageType;
/// 当前登录用户是否为消息的发送方
@property (nonatomic, assign) BOOL isSender;
/// 消息发送方的昵称
@property (nonatomic, copy) NSString *from;

/// 消息的附件远程地址
@property (nonatomic, copy) NSString *fileURLPath;

/// 文本消息的文字
@property (nonatomic, copy) NSString *text;


/// 语音消息是否正在播放
@property (nonatomic, assign) BOOL isMediaPlaying;
/// 语音消息是否已经播放过
@property (nonatomic, assign) BOOL isMediaPlayed;
/// 语音消息(或视频消息)时长
@property (nonatomic, assign) CGFloat mediaDuration;
/// 音频local路径 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
@property (nonatomic, copy) NSString *mediaLocalPath;


/// 图片消息原图的大小
@property (nonatomic, assign) CGSize imageSize;
/// 图片消息的原图
@property (nonatomic, strong) UIImage *image;
/// 图片消息缩略图的大小
@property (nonatomic, assign) CGSize thumbnailImageSize;
/// 图片消息的缩略图
@property (nonatomic, strong) UIImage *thumbnailImage;

/// 缩略图默认显示的图片名(防止缩略图下载失败后，无显示内容)
@property (nonatomic, copy) NSString *failImageName;
/// 图片消息(或视频消息)的缩略图本地存储路径
@property (nonatomic, copy) NSString *thumbnailFileLocalPath;
/// 图片消息(或视频消息)的缩略图远程地址
@property (nonatomic, copy) NSString *thumbnailFileURLPath;




///// 消息发送方的头像url
//@property (nonatomic, copy) NSString *avatarURLPath;
//
///// 消息发送方的头像
//@property (nonatomic, strong) UIImage *avatarImage;



/**
 初始化消息对象模型

 @param message 消息对象
 @return 消息对象模型
 */
- (instancetype)initWithMessage:(EMMessage *)message;

@end
