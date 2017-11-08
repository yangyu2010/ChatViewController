//
//  MessageModel.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


- (instancetype)initWithMessage:(EMMessage *)message {
    self = [super init];
    if (self) {
        
        _cellHeight = -1;
        _message = message;
        _firstMessageBody = message.body;
        _messageId = message.messageId;
        _messageStatus = EMMessageStatusPending;
        _messageType = message.chatType;
        _bodyType = message.body.type;
        _isSender = (message.direction == EMMessageDirectionSend);
        _from = message.from;

        switch (_firstMessageBody.type) {
            case EMMessageBodyTypeText:
            {
                EMTextMessageBody *textBody = (EMTextMessageBody *)_firstMessageBody;
                self.text = textBody.text;
            }
                break;
            case EMMessageBodyTypeImage: {
                
                EMImageMessageBody *imgMessageBody = (EMImageMessageBody *)_firstMessageBody;
                
                self.imageSize = imgMessageBody.size;
                
                NSData *imageData = [NSData dataWithContentsOfFile:imgMessageBody.localPath];
                
                if (imageData.length) {
                    self.image = [UIImage imageWithData:imageData];
                }
                
                if ([imgMessageBody.thumbnailLocalPath length] > 0) {
                    self.thumbnailImage = [UIImage imageWithContentsOfFile:imgMessageBody.thumbnailLocalPath];
                    if (self.thumbnailImage) {
                        self.thumbnailImageSize = self.thumbnailImage.size;
                    } else {
                        CGSize size = imgMessageBody.size;
                        if (size.width > 100) {
                            CGFloat width = 100.0;
                            CGFloat height = width / size.width * size.height;
                            self.thumbnailImageSize = CGSizeMake(width, height);
                        } else {
                            self.thumbnailImageSize = size;
                        }
                    }
                } else {
                    if (self.image) {
                        CGSize size = self.image.size;
                        self.thumbnailImage = size.width * size.height > 200 * 200 ? [self scaleImage:self.image toScale:sqrt((200 * 200) / (size.width * size.height))] : self.image;
                        self.thumbnailImageSize = self.thumbnailImage.size;
                    } else {
                        CGSize size = imgMessageBody.size;
                        if (size.width > 100) {
                            CGFloat width = 100.0;
                            CGFloat height = size.width / width * size.height;
                            self.thumbnailImageSize = CGSizeMake(width, height);
                        } else {
                            self.thumbnailImageSize = size;
                        }
                    }
                }

                if (!_isSender) {
                    self.fileURLPath = imgMessageBody.remotePath;
                }
                
            }
                break;
                
            case EMMessageBodyTypeVoice: {
                
                EMVoiceMessageBody *voiceBody = (EMVoiceMessageBody *)_firstMessageBody;
                self.mediaDuration = voiceBody.duration;
                self.isMediaPlayed = NO;
                if (message.ext) {
                    self.isMediaPlayed = [[message.ext objectForKey:@"isPlayed"] boolValue];
                }
                
                // audio file path
                self.fileURLPath = voiceBody.remotePath;
                self.mediaLocalPath = voiceBody.localPath;
            }
                break;
             default:
                break;
        }

    }
    return self;
}

#pragma mark- Private
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
