//
//  ChatController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/30.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatController.h"
#import "ChatToolBar.h"
#import "UIColor+Utils.h"
#import "UIView+Sugar.h"
#import "VoiceRecordController.h"
#import "ChatToolBarMoreView.h"
#import "ChatToolBarHeader.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "ChatHelp.h"
#import "MessageTimeCell.h"
#import "MessageCellHeader.h"
#import "NSDate+Category.h"
#import <Hyphenate/Hyphenate.h>

#define kChatToolBarHeight                   49.0

#define KChatToolBarMoreViewHeight           200.0

/// 录音定时器 间隔
#define KRecordTimerDuration                 0.2
/// 最多录制时间
#define kRecordMaxRecordDurtion              10
/// 剩余多少s开始提示用户
#define kRecordRemainCountingDuration        5

@interface ChatController ()
                                <EMChatManagerDelegate,
                                UITableViewDelegate,
                                UITableViewDataSource,
                                ChatToolBarDelegate,
                                ChatToolBarMoreViewDelegate,
                                UINavigationControllerDelegate,
                                UIImagePickerControllerDelegate,
                                MessageCellDelegate>


{
    /// 底部toolbar的高度
    CGFloat _toolBarViewHeight;
    /// 记录toolbar高度, _toolBarViewHeight有时会被情况, 当前这个值会保留当前输入框里文字的高度
    CGFloat _toolBarViewOriginHeight;
    /// 底部toolbar y值
    CGFloat _toolBarViewY;
    /// 底部moreView y值
    CGFloat _toolBarMoreViewY;
    /// 当前toolbar的状态
    ChatToolBarState _chatToolBarState;
    /// table y值
    CGFloat _tableViewY;
    
    /// 是否需要根据键盘来调整页面
    BOOL _isNeedNotifKeyboard;
    
    /// 定时器
    NSTimer *_timerVoice;
    /// 当前录制的时间
    float _recordCurrentDuration;
    /// 当前的录音状态
    VoiceRecordState _recordCurrentState;

    /// 消息队列
    dispatch_queue_t _queueMessage;
}

/// 底部toolbar
@property (nonatomic, strong) ChatToolBar *toolBar;
/// 录制语言时状态显示的View
@property (nonatomic, strong) VoiceRecordController *ctrVoiceRecord;
/// +号更多 View
@property (nonatomic, strong) ChatToolBarMoreView *viewMore;
/// 聊天的tableView
@property (nonatomic, strong) UITableView *tableChat;

/// 相机 图册
@property (nonatomic, strong) UIImagePickerController *pickerImage;

/// 当前会话
@property (nonatomic, strong) EMConversation *conversation;
/// model 数组 里面存有MessageModel 和 时间字符串
@property (nonatomic, strong) NSMutableArray *arrModels;
/// 消息源, 只保存
@property (nonatomic, strong) NSMutableArray <EMMessage *> *arrMessages;
/// 时间间隔标记 默认是0, 如果记录了一次时间, 就把这个时间赋值给当前
@property (nonatomic, assign) NSTimeInterval timeIntervalMessageTag;


@end

@implementation ChatController

#pragma mark- Init

#pragma mark- Get

/// tableView
- (UITableView *)tableChat {
    if (_tableChat == nil) {
        _tableChat = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableChat.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
        _tableChat.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableChat.dataSource = self;
        _tableChat.delegate = self;
    }
    return _tableChat;
}

/// 底部toolbar
- (ChatToolBar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[ChatToolBar alloc] init];
    }
    return _toolBar;
}

/// +号更多 View
- (ChatToolBarMoreView *)viewMore {
    if (_viewMore == nil) {
        _viewMore = [[ChatToolBarMoreView alloc] init];
        _viewMore.delegate = self;
    }
    return _viewMore;
}

/// 录制语言时状态显示的View
- (VoiceRecordController *)ctrVoiceRecord {
    if (_ctrVoiceRecord == nil) {
        _ctrVoiceRecord = [[VoiceRecordController alloc] init];
    }
    return _ctrVoiceRecord;
}

/// 相机 图册
//- (UIImagePickerController *)pickerImage {
//    if (_pickerImage == nil) {
//        _pickerImage = [[UIImagePickerController alloc] init];
//        _pickerImage.delegate = self;
//    }
//    return _pickerImage;
//}

#pragma mark- Life cricle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewConfig];
    [self dataConfig];
    [self actionAddNotifications];
    [self actionGetConversation];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_pickerImage){
        [_pickerImage dismissViewControllerAnimated:NO completion:nil];
        _pickerImage = nil;
    }
}

#pragma mark- UI

- (void)viewConfig {
    
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    self.title = @"聊天";

    [self.view addSubview:self.tableChat];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.viewMore];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionViewTap)];
    [self.tableChat addGestureRecognizer:tap];
    
    
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    self.toolBar.frame = CGRectMake(0, _toolBarViewY, self.view.bounds.size.width, _toolBarViewHeight);
    
    self.viewMore.frame = CGRectMake(0, _toolBarMoreViewY, self.view.bounds.size.width, KChatToolBarMoreViewHeight);
    
    _tableViewY = -(self.view.height - _toolBarViewY - _toolBarViewHeight);

    self.tableChat.frame = CGRectMake(0, _tableViewY, self.view.bounds.size.width, self.view.bounds.size.height - _toolBarViewHeight);
    
    [self _scrollViewToBottom];
}


#pragma mark- Data

- (void)dataConfig {
    
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewOriginHeight = 0;
    _toolBarViewY = [[UIScreen mainScreen] bounds].size.height - _toolBarViewHeight;
    _toolBarMoreViewY = [[UIScreen mainScreen] bounds].size.height;
    _tableViewY = 0;
    _chatToolBarState = ChatToolBarStateNoraml;
    
    self.toolBar.delegate = self;
    
    _recordCurrentDuration = 0;
    
    _recordCurrentState = VoiceRecordStateNoraml;
    
    _isNeedNotifKeyboard = YES;
    
    self.arrModels = [NSMutableArray array];
    self.arrMessages = [NSMutableArray array];
    
    _queueMessage = dispatch_queue_create("com.musjoy.chat", NULL);
    
    self.timeIntervalMessageTag = -1;

    
    dispatch_async(_queueMessage, ^{
        self.pickerImage = [[UIImagePickerController alloc] init];
        self.pickerImage.delegate = self;
    });
    

}


#pragma mark- Notification

/// 添加通知
- (void)actionAddNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



#pragma mark- Action

/// 重置当前toolBar的frame
- (void)actionResetToolBarFrame {
    
    _chatToolBarState = ChatToolBarStateNoraml;
    _toolBarViewOriginHeight = _toolBarViewHeight;
    _toolBarViewHeight = kChatToolBarHeight;
    _toolBarViewY = CGRectGetMaxY(self.toolBar.frame) - _toolBarViewHeight;
    
    [self actionUpdateLayoutDuration:0];
}

/// 点击空白处 放弃编辑
- (void)actionViewTap {
    
    if (_toolBarViewY >= self.view.height - _toolBarViewHeight) {
        return ;
    }
    
    _chatToolBarState = ChatToolBarStateNoraml;
    _toolBarMoreViewY = self.view.height;
    _toolBarViewY = self.view.height - _toolBarViewHeight;
    [self actionUpdateLayoutDuration:0.0f];
    [self.toolBar resetState];

}

/// 刷新界面 duration为0则是默认值
- (void)actionUpdateLayoutDuration:(CGFloat)duration {
    
    if (duration <= 0) {
        duration = 0.25f;
    }
    
    [self.view setNeedsLayout];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark- 输入框处理 相关

/// 监听键盘事件 改变table 和 输入框的位置
- (void)actionKeyboardWillChangeFrame:(NSNotification *)notification {
    
    if (_isNeedNotifKeyboard == NO) {
        _isNeedNotifKeyboard = YES;
        return ;
    }
    
    NSDictionary *userInfo = notification.userInfo;
    
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _toolBarViewY = endFrame.origin.y - _toolBarViewHeight;
    
    [self actionUpdateLayoutDuration:duration];
}

/// 输入框会根据内容的多少来改变自生高度
- (void)chatToolBarInputViewContentHeightChanged:(CGFloat)height {

    _toolBarViewHeight += height;
    _toolBarViewY = self.toolBar.y - height;
    
    [self actionUpdateLayoutDuration:0.10f];
}

/// 发送文本
- (void)chatToolBarSendText:(NSString *)text {
    
    [self actionResetToolBarFrame];
    
    _toolBarViewOriginHeight = 0;
    
    [self actionSendTextMessage:text];
}

#pragma mark- More View 相关

/// 点击+事件
- (void)chatToolBarMoreViewActionState:(BOOL)isSelected {
    
    if (_toolBarViewOriginHeight != 0) {
        _toolBarViewHeight = _toolBarViewOriginHeight;
        _toolBarViewOriginHeight = 0;
    }
    
    if (isSelected) {
        _chatToolBarState = ChatToolBarStateMore;
        _toolBarMoreViewY = self.view.height - KChatToolBarMoreViewHeight;
        _toolBarViewY = _toolBarMoreViewY - _toolBarViewHeight;

    } else {
        _chatToolBarState = ChatToolBarStateInput;
        _toolBarMoreViewY = self.view.height;
        _isNeedNotifKeyboard = NO;
    }
    
    [self actionUpdateLayoutDuration:0];
}

#pragma mark- MoreView Delegate
- (void)chatToolBarMoreViewPictureAction:(ChatToolBarMoreView *)view {
    
    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)chatToolBarMoreViewShootAction:(ChatToolBarMoreView *)view {
    
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark- 处理照片相关

/// 弹出照片库
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType {
    
    self.pickerImage.sourceType = sourceType;
    [self presentViewController:self.pickerImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self actionSendImageMessage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- 录制语音 相关

/// 点击录音按钮事件
- (void)chatToolBarVoiceRecoredActionState:(BOOL)isSelected {
    
    if (_toolBarViewOriginHeight != 0) {
        _toolBarViewHeight = _toolBarViewOriginHeight;
        _toolBarViewOriginHeight = 0;
    }
    
    if (isSelected) {
        [self actionResetToolBarFrame];
        
        // 在录音
        _chatToolBarState = ChatToolBarStateVoice;
        _toolBarMoreViewY = self.view.height;
        _toolBarViewHeight = kChatToolBarHeight;
        _toolBarViewY = self.view.height - kChatToolBarHeight;
        
    } else {
        // 取消录音, 就是正在输入
        _chatToolBarState = ChatToolBarStateInput;
    }
    
    [self actionUpdateLayoutDuration:0];
}

/// 循环调用的方法
- (void)actionRecordVoiceTimeOut {
    
    _recordCurrentDuration += KRecordTimerDuration;
    float remainTime = kRecordMaxRecordDurtion - _recordCurrentDuration;
    if ((int)remainTime == 0) {
        // 录制结束
        [self actionRecordVoiceFinished];
    } else if ([self actionRecordVoiceViewShouldCounting]) {
        // 倒计时
        _recordCurrentState = VoiceRecordStateTouchUpCounting;
        [self actionUpdateVoiceRecordState];
        [self.ctrVoiceRecord updateCountingRemainTime:remainTime];
    } else {
        // 正在录制
        float fakePower = (float)(1 + arc4random() % 99) / 100;
        [self.ctrVoiceRecord updateRecordingPower:fakePower];
    }
}

/// 开始定时器 录制
- (void)actionStartRecordVoiceTimer {
    if (_timerVoice) {
        [_timerVoice invalidate];
        _timerVoice = nil;
    }
    
    _timerVoice = [NSTimer scheduledTimerWithTimeInterval:KRecordTimerDuration target:self selector:@selector(actionRecordVoiceTimeOut) userInfo:nil repeats:YES];
    [_timerVoice fire];
}

/// 结束定时器
- (void)actionStopRecordVoiceTimer {
    if (_timerVoice) {
        [_timerVoice invalidate];
        _timerVoice = nil;
    }
}

/// 更新状态
- (void)actionUpdateVoiceRecordState {
    
    if (_recordCurrentState == VoiceRecordStateStart) {
        [self actionStartRecordVoiceTimer];
    }
    else if (_recordCurrentState == VoiceRecordStateCanceled ||
             _recordCurrentState == VoiceRecordStateFinished) {
        [self actionRecordVoiceFinished];
    }
    [self.ctrVoiceRecord updateUIWithRecordState:_recordCurrentState];
}

/// 录制语音结束
- (void)actionRecordVoiceFinished {

    if (_recordCurrentDuration < 1.0) {
        [self.ctrVoiceRecord showToast:@"录制太短了..."];
    }
    
    [self actionStopRecordVoiceTimer];
    _recordCurrentDuration = 0;
    _recordCurrentState = VoiceRecordStateNoraml;
    [self.ctrVoiceRecord updateUIWithRecordState:_recordCurrentState];
}

/// 判断当前录制的view 是否需要显示 倒计时
- (BOOL)actionRecordVoiceViewShouldCounting {
    
    if ((_recordCurrentDuration >= (kRecordMaxRecordDurtion - kRecordRemainCountingDuration)) &&
        (_recordCurrentDuration < kRecordMaxRecordDurtion) &&
        (_recordCurrentState != VoiceRecordStateTouchUpCancel)) {
        
        return YES;
    }
    
    return NO;
}

- (void)chatToolBarVoiceRecordState:(VoiceRecordState)state {
    _recordCurrentState = state;
    
    [self actionUpdateVoiceRecordState];
}

#pragma mark- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /// arrmodels里如果存储的是字符串, 代表这个位置应该显示个时间
    id object = [self.arrModels objectAtIndex:indexPath.item];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *cellIdentifierTime = [MessageTimeCell cellIdentifier];
        MessageTimeCell *timeCell = (MessageTimeCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifierTime];
        
        if (timeCell == nil) {
            timeCell = [[MessageTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTime];
        }
        
        timeCell.strTime = object;
        return timeCell;
    }
    
    /// 正常的消息cell
    MessageModel *model = object;
    NSString *cellIdentifier = [MessageCell cellIdentifierWithModel:model];
    MessageCell *cell = (MessageCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier model:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = model;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = [self.arrModels objectAtIndex:indexPath.item];
    if ([object isKindOfClass:[NSString class]]) {
        return [MessageTimeCell cellHeight];
    }
    
    MessageModel *model = self.arrModels[indexPath.item];
    return [MessageCell cellHeightWithModel:model];
}

#pragma mark- cell 代理
- (void)messageCellDidSelectedStatusButton:(MessageCell *)cell model:(MessageModel *)model {
    
    if ((model.messageStatus != EMMessageStatusFailed) &&
        (model.messageStatus != EMMessageStatusPending)) {
        return;
    }
    
    __weak typeof(self) weakself = self;
    model.messageStatus = EMMessageStatusDelivering;
    
    NSUInteger index = NSNotFound;
    index = [self.arrModels indexOfObject:model];
    if (index == NSNotFound) {
        [self.tableChat reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [self.tableChat reloadData];
    }
    
    [[EMClient sharedClient].chatManager resendMessage:model.message progress:nil completion:^(EMMessage *message, EMError *error) {
        [weakself actionRefreshSendMessageStatus:message];
    }];
}


#pragma mark- 聊天相关
/// 获取会话 和 聊天记录
- (void)actionGetConversation {
    
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    self.conversation = [[EMClient sharedClient].chatManager getConversation:self.conversationId type:EMConversationTypeChat createIfNotExist:YES];
    
    [self.conversation loadMessagesStartFromId:@"" count:40 searchDirection:EMMessageSearchDirectionUp completion:^(NSArray *aMessages, EMError *aError) {
        
        for (EMMessage *message in aMessages) {
            /// 判断会话id 和 当前消息id是否一致
            if (![self.conversationId isEqualToString:message.conversationId]) {
                break;
            }

            if (message.body.type == EMMessageBodyTypeText ||
                message.body.type == EMMessageBodyTypeImage ||
                message.body.type == EMMessageBodyTypeVoice) {
            
                
                CGFloat interval = (self.timeIntervalMessageTag - message.timestamp) / 1000;
                if (self.timeIntervalMessageTag < 0 || interval > kTimeIntervalMessageTag || interval < -kTimeIntervalMessageTag) {
                    NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
                    [self.arrModels addObject:[messageDate formattedTime]];
                    self.timeIntervalMessageTag = message.timestamp;
                }
                
                
                [self.conversation appendMessage:message error:nil];
                MessageModel *model = [[MessageModel alloc] initWithMessage:message];
                
                [self.arrModels addObject:model];
                [self.arrMessages addObject:message];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableChat reloadData];
            [self _scrollViewToBottom];
        });
        
    }];
    
}

/// 滑动最底部
- (void)_scrollViewToBottom {
    
    NSInteger rows = [self.tableChat numberOfRowsInSection:0];
    
    if (rows > 0) {
        [self.tableChat scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:NO];
    }

}



#pragma mark- 聊天代理 EMChatManagerDelegate
- (void)messagesDidReceive:(NSArray *)aMessages {
    
    for (EMMessage *message in aMessages) {
        /// 判断会话id 和 当前消息id是否一致
        if (![self.conversationId isEqualToString:message.conversationId]) {
            break;
        }
        
        if (message.body.type == EMMessageBodyTypeText ||
            message.body.type == EMMessageBodyTypeImage ||
            message.body.type == EMMessageBodyTypeVoice) {
        
            [self.conversation appendMessage:message error:nil];
            MessageModel *model = [[MessageModel alloc] initWithMessage:message];
            [self.arrModels addObject:model];
            [self.arrMessages addObject:message];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableChat reloadData];
        [self _scrollViewToBottom];
    });
    
}

#pragma mark- 发送消息
/// 发送一个消息到服务器
- (void)actionSendMessage:(EMMessage *)message {
    
    
    NSLog(@"actionSendMessage %@", message.messageId);
    
    [self actionAddMessageToSource:message];
    
    __weak typeof(self) weakself = self;
    [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        
    } completion:^(EMMessage *message, EMError *error) {

        NSLog(@"actionSendMessage completion %@", message.messageId);
        
        [weakself actionRefreshSendMessageStatus:message];

    }];
}

/// 发送消息, 先把消息加到数据源里, 也就是先显示出来
- (void)actionAddMessageToSource:(EMMessage *)message {
    
    __weak ChatController *weakSelf = self;

    dispatch_async(_queueMessage, ^{
        NSArray *messages = [weakSelf actionFormatTimeMessage:@[message]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.arrModels addObjectsFromArray:messages];
            [weakSelf.arrMessages addObject:message];
            [weakSelf.tableChat reloadData];
            [weakSelf _scrollViewToBottom];

        });
    });
}

/// 处理消息, 因为要处理时间, 转换成自己的model
- (NSArray *)actionFormatTimeMessage:(NSArray *)messages {
    
    NSMutableArray *arrFormatted = [[NSMutableArray alloc] init];
    if ([messages count] == 0) {
        return arrFormatted;
    }
    for (EMMessage *message in messages) {
        
        /// 1.判断时间, 如果需要显示时间, 就创建一个加入数组中
        CGFloat interval = (self.timeIntervalMessageTag - message.timestamp) / 1000;
        if (self.timeIntervalMessageTag < 0 || interval > kTimeIntervalMessageTag || interval < -kTimeIntervalMessageTag) {
            NSDate *messageDate = [NSDate dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)message.timestamp];
            [self.arrModels addObject:[messageDate formattedTime]];
            self.timeIntervalMessageTag = message.timestamp;
        }
        
        /// 2.添加自己的model
        MessageModel *model = [[MessageModel alloc] initWithMessage:message];
        [arrFormatted addObject:model];
        
        NSLog(@"messageId2 %@", message.messageId);
        
    }

    return arrFormatted;
}

/// 更新发送了的消息状态, 是否成功, 失败
- (void)actionRefreshSendMessageStatus:(EMMessage *)message {
    
    if (self.arrModels.count == 0) {
        return ;
    }
    
    __block NSUInteger index = NSNotFound;
    index = NSNotFound;
    
    NSLog(@"actionRefreshSendMessageStatus %@", message.messageId);
    
    [self.arrModels enumerateObjectsUsingBlock:^(MessageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[MessageModel class]]) {
            NSLog(@"enumerateObjectsUsingBlock %@", obj.messageId);
            
            NSLog(@"11 %@", obj.text) ;
        }
        
        
        if ([obj isKindOfClass:[MessageModel class]] &&
            [obj.messageId isEqualToString:message.messageId]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index == NSNotFound) {
        return ;
    }
    
    MessageModel *model = self.arrModels[index];
    model.messageStatus = message.status;
    [self.tableChat reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

/// 发送文字消息方法
- (void)actionSendTextMessage:(NSString *)text {
    if (text.length == 0) {
        return ;
    }
    
    EMMessage *message = [ChatHelp getTextMessage:text to:self.conversationId];
    [self actionSendMessage:message];
}

/// 发送图片消息对象
- (void)actionSendImageMessage:(UIImage *)image {
    if (image == nil) {
        return ;
    }

    EMMessage *message = [ChatHelp getImageMessage:image to:self.conversationId];
    [self actionSendMessage:message];
}

@end
