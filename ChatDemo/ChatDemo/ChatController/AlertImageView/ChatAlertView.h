//
//  ChatAlertView.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChatAlertViewDelegate <NSObject>

- (void)chatAlertViewCancelAction;

- (void)chatAlertViewSendAction;

@end



@interface ChatAlertView : UIView

@property (nonatomic, weak) id <ChatAlertViewDelegate> delegate;

- (void)setImage:(UIImage *)image;

- (void)updateImageViewWidth:(CGFloat)width;

@end
