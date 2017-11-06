//
//  ConversationListController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ConversationListController.h"
#import <Hyphenate/Hyphenate.h>
#import "ChatController.h"

@interface ConversationListController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_arrData;
}
@property (nonatomic, strong) UITableView *tableConversationList;

@end

@implementation ConversationListController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self viewConfig];
    [self dataConfig];
}


- (void)viewConfig {
    _tableConversationList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableConversationList.delegate = self;
    _tableConversationList.dataSource = self;
    [self.view addSubview:_tableConversationList];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    _tableConversationList.frame = self.view.bounds;
}

- (void)dataConfig {
    
    _arrData = [NSMutableArray array];
    
   
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];

    NSLog(@"getAllConversations %@", conversations);
    
    [_arrData addObjectsFromArray:conversations];
    
    [self.tableConversationList reloadData];
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
    
    EMConversation *cv = _arrData[indexPath.item];
    
    cell.textLabel.text = cv.conversationId;
    cell.detailTextLabel.text = cv.latestMessage.from;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatController *vcChat = [[ChatController alloc] init];
    vcChat.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vcChat animated:YES];
}


@end
