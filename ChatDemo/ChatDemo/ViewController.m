//
//  ViewController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "TabBarViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtfUsername;

@property (weak, nonatomic) IBOutlet UITextField *txtfPassword;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (IBAction)actionLogin:(id)sender {
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.txtfUsername.text password:self.txtfPassword.text];
    if (!error) {
        //[[EMClient sharedClient].options setIsAutoLogin:YES];
        NSLog(@"登录成功");

        TabBarViewController *tabBar = [[TabBarViewController alloc] init];
        [self restoreRootViewController:tabBar];
        
    } else {
        NSLog(@"actionRegister error %@", error.errorDescription);
    }
}


- (IBAction)actionRegister:(id)sender {
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.txtfUsername.text password:self.txtfPassword.text];
    if (error == nil) {
        NSLog(@"注册成功");
    } else {
        NSLog(@"actionLogin error %@", error.errorDescription);
    }

}

#pragma mark- Private
// 登陆后淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController {
    
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}


@end
