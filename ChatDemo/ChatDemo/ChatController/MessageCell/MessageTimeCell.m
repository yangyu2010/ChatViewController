//
//  MessageTimeCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/9.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "MessageTimeCell.h"
#import "MessageCellHeader.h"
#import "UIColor+Utils.h"

@interface MessageTimeCell ()

@property (nonatomic, strong) UILabel *lblTime;

@end

@implementation MessageTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self viewConfig];
    }
    return self;
}



#pragma mark- UI

- (void)viewConfig {
    self.contentView.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.lblTime = [[UILabel alloc] init];
    self.lblTime.translatesAutoresizingMaskIntoConstraints = NO;
    self.lblTime.textAlignment = NSTextAlignmentCenter;
    self.lblTime.backgroundColor = [UIColor clearColor];
    self.lblTime.textColor = [UIColor grayColor];
    self.lblTime.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.lblTime];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.lblTime.frame = self.bounds;
//    self.lblTime.center = self.contentView.center;
}


#pragma mark- Public
- (void)setStrTime:(NSString *)strTime {
    _strTime = strTime;
    
    self.lblTime.text = _strTime;
}

+ (NSString *)cellIdentifier {
    return kMessageCellIdentifierTime;
}

/// 获取cell的高度
+ (CGFloat)cellHeight {
    return kMessageTimeCellHeight;
}

@end
