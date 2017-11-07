//
//  MJBubbleView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/6.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MJBubbleView.h"

@implementation MJBubbleView

- (instancetype)initWithIsSender:(BOOL)isSender {
    self = [super init];
    if (self) {
        _isSender = isSender;
        
        [self viewConfig];
    }
    return self;
}

#pragma mark- UI
- (void)viewConfig {
    [self addSubview:self.imgViewBackground];
    
    if (_isSender) {
        self.imgViewBackground.image = [UIImage imageNamed:@"message_right"];
    } else {
        self.imgViewBackground.image = [UIImage imageNamed:@"message_left"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgViewBackground.frame = self.bounds;
    
}

#pragma mark- Get
- (UIImageView *)imgViewBackground {
    if (_imgViewBackground == nil) {
        _imgViewBackground = [[UIImageView alloc] init];
        _imgViewBackground.translatesAutoresizingMaskIntoConstraints = NO;
        _imgViewBackground.backgroundColor = [UIColor clearColor];
    }
    return _imgViewBackground;
}

@end
