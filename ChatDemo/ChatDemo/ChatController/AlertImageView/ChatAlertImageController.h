//
//  ChatAlertImageController.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatAlertView.h"

@protocol ChatAlertImageControllerDelegate <NSObject>

- (void)chatAlertImageControllerSendImage:(UIImage *)image;

@end

@interface ChatAlertImageController : UIViewController

@property (nonatomic, strong) ChatAlertView *viewAlert;
@property (nonatomic, strong) UIView *viewBackground;

- (instancetype)initWithImage:(UIImage *)image ;

@property (nonatomic, weak) id <ChatAlertImageControllerDelegate> delegate;

@end
