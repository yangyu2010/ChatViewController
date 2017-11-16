//
//  ChatAlertView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatAlertView.h"
#import "UIColor+Utils.h"

@interface ChatAlertView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewShow;

@property (weak, nonatomic) IBOutlet UIView *viewBorder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consImageViewShowWidth;


@end;

@implementation ChatAlertView


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    
    self.viewBorder.layer.borderWidth = 0.5;
    self.viewBorder.layer.borderColor = [UIColor colorFromHexRGB:@"CBCBCB"].CGColor;
    self.viewBorder.layer.masksToBounds = YES;
    self.viewBorder.layer.cornerRadius = 3.0;
    
}

#pragma mark- Action

- (IBAction)actionCancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatAlertViewCancelAction)]) {
        [self.delegate chatAlertViewCancelAction];
    }
}

- (IBAction)actionSend:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatAlertViewSendAction)]) {
        [self.delegate chatAlertViewSendAction];
    }
}


#pragma mark- Public
- (void)setImage:(UIImage *)image {
    self.imgViewShow.image = image;
}

- (void)updateImageViewWidth:(CGFloat)width {
    self.consImageViewShowWidth.constant = width;
}

@end
