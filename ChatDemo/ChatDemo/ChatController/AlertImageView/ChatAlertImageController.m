//
//  ChatAlertImageController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatAlertImageController.h"
#import "ChatAlertAnimator.h"

@interface ChatAlertImageController () <ChatAlertViewDelegate>
{
    UIImage *_imageShow;
    
    ChatAlertAnimator *_animator;
}


@end

@implementation ChatAlertImageController

#pragma mark- Init

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        
        _imageShow = image;
        
        _animator = [ChatAlertAnimator new];
        
        /// 设置自己为转场代理
        self.transitioningDelegate = _animator;

        /// 自定义转场模式
        self.modalPresentationStyle = UIModalPresentationCustom;
        
    }
    return self;
}

#pragma mark- Life cricle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self dataConfig];
    [self viewConfig];
}


#pragma mark- UI

- (void)viewConfig {
    
    self.viewBackground = [[UIView alloc] init];
    self.viewBackground.backgroundColor = [UIColor blackColor];
    self.viewBackground.alpha = 0.4;
    [self.view addSubview:self.viewBackground];
    
    
    self.viewAlert = [[NSBundle mainBundle] loadNibNamed:@"ChatAlertView" owner:nil options:nil].firstObject;
    [self.view addSubview:self.viewAlert];
    self.viewAlert.delegate = self;
    [self.viewAlert setImage:_imageShow];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.viewBackground.frame = self.view.bounds;
    
    
    CGFloat width = self.view.bounds.size.width - 2 * 30;
    
    CGFloat imgViewMaxWidth = width - 2 * 20 - 2 * 5;
    CGFloat imgViewMaxHeight = imgViewMaxWidth;

    CGFloat imageViewWidth = 0;
    CGFloat imageViewHeight = 0;

    if (_imageShow.size.width > _imageShow.size.height) {
        
        if (_imageShow.size.width > imgViewMaxWidth) {
            /// 如果图片的宽度大于最大的宽度
            imageViewWidth = imgViewMaxWidth;
            imageViewHeight = imageViewWidth / _imageShow.size.width * _imageShow.size.height;
        
        } else {
            /// 宽度不大于, 判断高度
            imageViewWidth = _imageShow.size.width;
            imageViewHeight = _imageShow.size.height;
        }

    } else {
        
        if (_imageShow.size.height > imgViewMaxHeight) {
            imageViewHeight = imgViewMaxHeight;
            imageViewWidth = imageViewHeight / _imageShow.size.height * _imageShow.size.width;
        } else {
            imageViewWidth = _imageShow.size.width;
            imageViewHeight = _imageShow.size.height;
        }
        
    }

    CGFloat alertViewHeight = imageViewHeight + 2 * 20 + 2 * 5 + 44 + 1;
    
    self.viewAlert.frame = CGRectMake(0, 0, width, alertViewHeight);
    self.viewAlert.center = self.view.center;
    
    [self.viewAlert updateImageViewWidth:imageViewWidth];
}

#pragma mark- Data

- (void)dataConfig {
    
    
    
//    CGFloat maxWidth =
}


#pragma mark- ChatAlertViewDelegate
- (void)chatAlertViewSendAction {
    
}

- (void)chatAlertViewCancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
