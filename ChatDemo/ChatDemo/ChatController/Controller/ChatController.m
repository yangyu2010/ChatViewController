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

#define kChatToolBarHeight 49.0

@interface ChatController () <ChatToolBarDelegate>
{
    EMConversation *_conversation;
    
    CGFloat _toolBarViewHeight;
}

@property (nonatomic, strong) ChatToolBar *toolBar;


@end

@implementation ChatController

#pragma mark- Init

- (instancetype)initWithConversationChatter:(NSString *)conversationChatter
                           conversationType:(EMConversationType)conversationType {
    if ([conversationChatter length] == 0) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        
        _conversation = [[EMClient sharedClient].chatManager getConversation:conversationChatter type:conversationType createIfNotExist:YES];
        
        [_conversation markAllMessagesAsRead:nil];
    }
    return self;
}

#pragma mark- Life cricle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    [self dataConfig];
}

#pragma mark- UI

- (void)viewConfig {
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];

    self.toolBar = [[ChatToolBar alloc] init];
    [self.view addSubview:self.toolBar];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    _toolBar.frame = CGRectMake(0, self.view.bounds.size.height - kChatToolBarHeight, self.view.bounds.size.width, kChatToolBarHeight);
    
    
    self.toolBar.frame = CGRectMake(0, 100, self.view.bounds.size.width, _toolBarViewHeight);
}

#pragma mark- Data

- (void)dataConfig {
    
    _toolBarViewHeight = kChatToolBarHeight;
    
    self.toolBar.delegate = self;
}


#pragma mark- Action

/// 重置当前toolBar的frame
- (void)actionResetToolBarFrame {
    
    _toolBarViewHeight = kChatToolBarHeight;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:0.15f animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark- ChatToolBarDelegate
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height {

    _toolBarViewHeight += height;
    
    [self.view setNeedsLayout];
    
    [UIView animateWithDuration:0.15f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)chatToolBarSendText:(NSString *)text {
    
    NSLog(@"发送消息: %@", text);
    
    [self actionResetToolBarFrame];
}


@end
