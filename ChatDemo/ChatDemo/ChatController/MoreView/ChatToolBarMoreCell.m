//
//  ChatToolBarMoreCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/2.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBarMoreCell.h"

@interface ChatToolBarMoreCell ()

/// 按钮 可以设置背景图 和 图片
@property (nonatomic, strong) UIButton *btnIcon;

/// 文本
@property (nonatomic, strong) UILabel *lblTitle;

@end

@implementation ChatToolBarMoreCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewConfig];
    }
    return self;
}


#pragma mark- UI

- (void)viewConfig {
    self.btnIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnIcon.userInteractionEnabled = NO;
    [self.btnIcon setBackgroundImage:[UIImage imageNamed:@"sharemore_other"] forState:UIControlStateNormal];
    [self.btnIcon setBackgroundImage:[UIImage imageNamed:@"sharemore_other_HL"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:self.btnIcon];
    
    self.lblTitle = [[UILabel alloc] init];
    self.lblTitle.textColor = [UIColor lightGrayColor];
    self.lblTitle.font = [UIFont systemFontOfSize:12.0];
    self.lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.lblTitle];
    
//    self.lblTitle.backgroundColor = [UIColor yellowColor];
//    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    CGFloat w = self.bounds.size.width - 15;
    self.btnIcon.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    self.btnIcon.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5 - 5);
    
    self.lblTitle.frame = CGRectMake(0, CGRectGetMaxY(self.btnIcon.frame), self.bounds.size.width, 20);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.btnIcon.highlighted = highlighted;
}

#pragma mark- Data

- (void)dataConfig {
    
}

- (void)configUIWithModel:(ChatToolBarMoreModel *)model {
    self.lblTitle.text = model.strTitle;
    [self.btnIcon setImage:[UIImage imageNamed:model.strIconName] forState:UIControlStateNormal];
}


@end
