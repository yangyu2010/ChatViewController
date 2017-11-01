//
//  ChatToolInputView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolInputView.h"
#import "UIColor+Utils.h"

@implementation ChatToolInputView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
    }
    return self;
}



#pragma mark- UI

- (void)viewConfig {
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.scrollIndicatorInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
//    self.contentInset = UIEdgeInsetsZero;
    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;
    self.font = [UIFont systemFontOfSize:16.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor colorFromHexRGB:@"FAFAFA"];
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeySend;
    self.textAlignment = NSTextAlignmentLeft;
    self.enablesReturnKeyAutomatically = YES;
    
    self.layer.borderColor = [UIColor colorFromHexRGB:@"E5E5E5"].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 3.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

#pragma mark- Data

- (void)dataConfig {
    
}


@end
