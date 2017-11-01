//
//  ChatToolBarVoiceView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBarVoiceView.h"
#import "UIColor+Utils.h"

@interface ChatToolBarVoiceView ()

/// 按钮
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ChatToolBarVoiceView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
        [self dataConfig];
    }
    return self;
}


#pragma mark- UI

- (void)viewConfig {
    self.backgroundColor = [UIColor clearColor];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.btn setTitle:@"Hold to talk" forState:UIControlStateNormal];
    [self.btn setTitle:@"Release to send" forState:UIControlStateHighlighted];
    [self.btn setTitleColor:[UIColor colorFromHexRGB:@"333333"] forState:UIControlStateNormal];
    self.btn.titleLabel.font = [UIFont systemFontOfSize:19.0];
    [self addSubview:self.btn];
    
    self.btn.layer.borderColor = [UIColor colorFromHexRGB:@"E5E5E5"].CGColor;
    self.btn.layer.borderWidth = 1.0f;
    self.btn.layer.cornerRadius = 3.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.btn.frame = self.bounds;
}

#pragma mark- Data

- (void)dataConfig {
    
    [self.btn addTarget:self action:@selector(actionHoldDownButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.btn addTarget:self action:@selector(actionHoldDownButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self.btn addTarget:self action:@selector(actionHoldDownButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.btn addTarget:self action:@selector(actionHoldDownDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [self.btn addTarget:self action:@selector(actionHoldDownDragInside) forControlEvents:UIControlEventTouchDragEnter];
}

#pragma mark- Action
- (void)actionHoldDownButtonTouchDown {
 
    NSLog(@"开始录制");
}

- (void)actionHoldDownButtonTouchUpOutside {
    NSLog(@"取消了");
}

- (void)actionHoldDownButtonTouchUpInside {
    NSLog(@"录制完成");
}

- (void)actionHoldDownDragOutside {
    NSLog(@"上滑");
}

- (void)actionHoldDownDragInside {
    NSLog(@"继续录制");
}


@end
