//
//  ChatAlertAnimator.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/16.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatAlertAnimator.h"
#import "ChatAlertImageController.h"

@interface ChatAlertAnimator () <UIViewControllerAnimatedTransitioning>
{
    BOOL _isPresented;
}
@end

@implementation ChatAlertAnimator

#pragma mark- UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    _isPresented = YES;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    _isPresented = NO;
    return self;
}



#pragma mark- UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.25f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (_isPresented) {
        [self presentedAnimateTransition:transitionContext];
    } else {
        [self dismissAnimateTransition:transitionContext];
    }
}


#pragma mark- Privete

- (void)presentedAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    ChatAlertImageController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toVC.viewBackground.alpha = 0.0;
    toVC.viewAlert.alpha = 0.0;
    toVC.viewAlert.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toVC.viewBackground.alpha = 0.4;
        toVC.viewAlert.alpha = 1.0;
        toVC.viewAlert.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)dismissAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                     animations:^{
                         fromVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}
@end
