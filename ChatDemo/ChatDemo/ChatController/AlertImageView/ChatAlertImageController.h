//
//  ChatAlertImageController.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatAlertView.h"

@interface ChatAlertImageController : UIViewController

@property (nonatomic, strong) ChatAlertView *viewAlert;
@property (nonatomic, strong) UIView *viewBackground;

- (instancetype)initWithImage:(UIImage *)image ;

@end
