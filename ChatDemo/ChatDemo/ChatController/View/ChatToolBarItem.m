//
//  ChatToolBarItem.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBarItem.h"

@interface ChatToolBarItem ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation ChatToolBarItem

#pragma mark- Init

- (instancetype)initWithIconName:(NSString *)iconName
{
    self = [super init];
    if (self) {
        [self viewConfig:iconName];
    }
    return self;
}

#pragma mark- UI

- (void)viewConfig:(NSString *)iconName {
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_HL", iconName]] forState:UIControlStateHighlighted];
    [_btn setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [_btn addTarget:self action:@selector(actionBtnTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _btn.frame = self.bounds;
}

#pragma mark- Action

- (void)actionBtnTouchUp:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarDidSelected:)]) {
        [self.delegate chatToolBarDidSelected:self];
    }
}

@end
