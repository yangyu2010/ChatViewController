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

- (instancetype)initWithIconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName
{
    self = [super init];
    if (self) {
        [self viewConfig:iconName selectedIconName:selectedIconName];
    }
    return self;
}

#pragma mark- UI

- (void)viewConfig:(NSString *)iconName selectedIconName:(NSString *)selectedIconName {
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_HL", iconName]] forState:UIControlStateHighlighted];
    [_btn setImage:[UIImage imageNamed:selectedIconName] forState:UIControlStateSelected];
    // keyboard
    
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
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarDidSelected:isSelected:)]) {
        [self.delegate chatToolBarDidSelected:self isSelected:btn.selected];
    }
}

#pragma mark- Public
/// 更新当前item的状态
- (void)updateItemState:(BOOL)isSelected {
    self.btn.selected = isSelected;
}

@end
