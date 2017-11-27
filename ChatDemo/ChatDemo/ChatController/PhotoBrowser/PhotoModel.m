//
//  PhotoModel.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (instancetype)initWithMessageModel:(MessageModel *)model {
    self = [super init];
    if (self) {
        
        self.placeholderImage = model.thumbnailImage;
        if (self.placeholderImage == nil) {
            self.placeholderImage = [UIImage imageWithContentsOfFile:model.thumbnailFileLocalPath];
        }
        
        self.imageSize = model.imageSize;
        self.imageURLString = model.remotePath;
        self.image = model.image;
        self.messageId = model.messageId;
    }
    return self;
}

@end
