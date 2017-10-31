//
//  TabBarViewController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "TabBarViewController.h"
#import "FriendListViewController.h"
#import "ConversationListController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ConversationListController *vcConversation = [[ConversationListController alloc] init];
    [self addChildVC:vcConversation title:@"聊天" image:@"tabBar_normal_popular" selectedImage:@"tabBar_selected_popular"];
    
    FriendListViewController *vcFriend = [[FriendListViewController alloc] init];
    [self addChildVC:vcFriend title:@"好友" image:@"tabBar_normal_all" selectedImage:@"tabBar_selected_all"];
    
}


- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    // 设置标题
    childVC.title = title;
    
    // 设置图片
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [childVC.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 加导航
    UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
