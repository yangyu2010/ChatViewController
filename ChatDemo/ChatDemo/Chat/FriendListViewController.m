//
//  FriendListViewController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "FriendListViewController.h"
#import <Hyphenate/Hyphenate.h>
#import "ChatController.h"

@interface FriendListViewController () <UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray *_arrData;
}
@property (nonatomic, strong) UITableView *tableContacts;

@end

@implementation FriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewConfig];
    [self dataConfig];
}


- (void)viewConfig {
    _tableContacts = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableContacts.delegate = self;
    _tableContacts.dataSource = self;
    [self.view addSubview:_tableContacts];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    _tableContacts.frame = self.view.bounds;
}

- (void)dataConfig {
    
    _arrData = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_arrData addObjectsFromArray:buddyList];
                [_tableContacts reloadData];
            });
        } else {
            NSLog(@"getContacts Error %@", error.errorDescription);
        }
        
    });
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _arrData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = _arrData[indexPath.item];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatController *vcChat = [[ChatController alloc] init];
    vcChat.hidesBottomBarWhenPushed = YES;
    vcChat.conversationId = _arrData[indexPath.item];
    [self.navigationController pushViewController:vcChat animated:YES];
}


@end
