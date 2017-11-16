//
//  ChatToolInputView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolInputView.h"
#import "UIColor+Utils.h"
#import "ChatControllerHeader.h"

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

    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorFromHexRGB:@"A3A5AB"].CGColor;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

#pragma mark- Rewrite
- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (BOOL) canPerformAction:(SEL)action withSender:(id)sender {
//    if ( [UIMenuController sharedMenuController] ) {
//        [UIMenuController sharedMenuController].menuVisible = NO;
//    }
    return YES;
}

/// 监听复制事件
- (void)paste:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (pasteboard.string.length > 0) {
        [super paste:sender];
        return ;
    }
    
    if (pasteboard.image != nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kChatTextViewPasteboardImageNotification object:pasteboard.image userInfo:nil];
        [self resignFirstResponder];
    }
}

#pragma mark- Data

- (void)dataConfig {
    
}


@end
