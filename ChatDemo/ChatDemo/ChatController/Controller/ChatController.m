//
//  ChatController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatController.h"
#import "ChatToolBar.h"
#import "UIColor+Utils.h"
#import "UIView+Sugar.h"

#define kChatToolBarHeight 49.0

@interface ChatController () <ChatToolBarDelegate>
{

    CGFloat _toolBarViewHeight;
    
    CGFloat _toolBarViewY;
}

@property (nonatomic, strong) ChatToolBar *toolBar;


@end

@implementation ChatController

#pragma mark- Init


#pragma mark- Life cricle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    [self dataConfig];
    [self actionAddNotifications];
}

#pragma mark- UI

- (void)viewConfig {
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    self.title = @"聊天";

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewTap)];
    [self.view addGestureRecognizer:tap];
    
    self.toolBar = [[ChatToolBar alloc] init];
    [self.view addSubview:self.toolBar];
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = [[UIScreen mainScreen] bounds].size.height - _toolBarViewHeight;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.toolBar.frame = CGRectMake(0, _toolBarViewY, self.view.bounds.size.width, _toolBarViewHeight);
    
    
//    self.toolBar.frame = CGRectMake(0, 100, self.view.bounds.size.width, _toolBarViewHeight);
}

#pragma mark- Data

- (void)dataConfig {
    
   
    self.toolBar.delegate = self;
}


#pragma mark- Notification

/// 添加通知
- (void)actionAddNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
}

/// 监听键盘事件 改变table 和 输入框的位置
- (void)actionKeyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [UIView animateWithDuration:duration animations:^{
        self.toolBar.y = endFrame.origin.y - _toolBarViewHeight;;
    }];
}

/// 键盘将要出现
- (void)actionKeyboardWillShow {
    
}

- (void)actionKeyboardWillHide {
    
}

#pragma mark- Action

/// 重置当前toolBar的frame
- (void)actionResetToolBarFrame {
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = CGRectGetMaxY(self.toolBar.frame) - _toolBarViewHeight;
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.15f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)actionViewTap {
    [self.view endEditing:YES];
}

#pragma mark- ChatToolBarDelegate
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height {

    _toolBarViewHeight += height;
    _toolBarViewY = self.toolBar.y - height;
    
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.10f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)chatToolBarResetInputViewHeight {
    [self actionResetToolBarFrame];
}

- (void)chatToolBarSendText:(NSString *)text {
    
    NSLog(@"发送消息: %@", text);
    
    [self actionResetToolBarFrame];
}


@end
