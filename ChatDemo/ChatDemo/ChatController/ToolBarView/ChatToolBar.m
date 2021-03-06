//
//  ChatToolBar.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBar.h"
#import "ChatToolBarItem.h"
#import "UIColor+Utils.h"
#import "VoiceRecordButton.h"
#import "ChatToolBarMoreView.h"
#import "ChatControllerHeader.h"

@interface ChatToolBar () <UITextViewDelegate, ChatToolBarItemDelegate>
{
    /// 保存输入框的内容高度
    CGFloat _oldContentHeight;
    
    /// 没有文字的时候 输入框的高度
    CGFloat _originContentHeight;

}

/// 语音item
@property (nonatomic, strong) ChatToolBarItem *itemVoice;

/// 表情item
@property (nonatomic, strong) ChatToolBarItem *itemFace;

/// 更多item
@property (nonatomic, strong) ChatToolBarItem *itemMore;

/// 输入框
@property (nonatomic, strong) ChatToolInputView *viewInput;

/// 语音输入按钮
@property (nonatomic, strong) VoiceRecordButton *btnVoice;


@end

@implementation ChatToolBar

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
        [self dataConfig];
        self.backgroundColor = [UIColor colorFromHexRGB:@"F3F3F3"];
    }
    return self;
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}


#pragma mark- UI

- (void)viewConfig {
    self.itemVoice = [[ChatToolBarItem alloc] initWithIconName:@"voice" selectedIconName:@"keyboard"];
    self.itemVoice.delegate = self;
    [self addSubview:self.itemVoice];
    
    self.itemFace = [[ChatToolBarItem alloc] initWithIconName:@"face" selectedIconName:@"keyboard"];
    [self addSubview:self.itemFace];
    
    self.itemMore = [[ChatToolBarItem alloc] initWithIconName:@"multiMedia" selectedIconName:@"multiMedia"];
    self.itemMore.delegate = self;
    [self addSubview:self.itemMore];
    
    self.viewInput = [[ChatToolInputView alloc] init];
    [self addSubview:self.viewInput];
    
    self.btnVoice = [VoiceRecordButton creatVoiceButton];
    [self addSubview:self.btnVoice];
    self.btnVoice.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemH = self.bounds.size.height;
    CGFloat itemW = 38.0;
    
    self.itemVoice.frame = CGRectMake(0, 0, itemW, itemH);
    self.itemMore.frame = CGRectMake(self.bounds.size.width - itemW, 0, itemW, itemH);
    self.itemFace.frame = CGRectMake(self.bounds.size.width - itemW * 2, 0, itemW, itemH);
    self.viewInput.frame = CGRectMake(itemW + 3, 7, self.bounds.size.width - itemW * 3 - 6, itemH - 14);
    self.btnVoice.frame = self.viewInput.frame;
}

#pragma mark- Data

- (void)dataConfig {
    
    _oldContentHeight = [self getTextViewContentH:self.viewInput];
    _originContentHeight = [self getTextViewContentH:self.viewInput];
    
    self.viewInput.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTextDidChangeNotification) name:UITextViewTextDidChangeNotification object:nil];
    
    
    [self actionAddRecordButtonAction];
}

#pragma mark- Text View 相关

- (void)didReceiveTextDidChangeNotification {
    
    CGFloat currentHeight = [self getTextViewContentH:self.viewInput];
    
    if (currentHeight == _oldContentHeight) {
        return ;
    }
    
    if ([self getTextViewLineCount:self.viewInput] >= 5) {
        [self.viewInput scrollRangeToVisible:NSMakeRange(self.viewInput.text.length - 2, 1)];
        return ;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarInputViewContentHeightChanged:)]) {
        [self.delegate chatToolBarInputViewContentHeightChanged:currentHeight - _oldContentHeight];
    }

    CGPoint bottomOffset = CGPointMake(0.0f, self.viewInput.contentSize.height - self.viewInput.bounds.size.height);
    [self.viewInput setContentOffset:bottomOffset animated:YES];
    [self.viewInput scrollRangeToVisible:NSMakeRange(self.viewInput.text.length - 2, 1)];
    
    _oldContentHeight = currentHeight;
    
}

/// 获取Text View 内容 高度
- (CGFloat)getTextViewContentH:(UITextView *)textView {
    return ceilf([textView sizeThatFits:textView.frame.size].height);
}

/// 获取当前TextView 行数
- (NSInteger)getTextViewLineCount:(UITextView *)textView {
    
    NSString *text = textView.text;
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(textView.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
  
    NSInteger lines = (NSInteger)(size.height / font.lineHeight);
    
    return lines;
}

#pragma mark- 录音 相关

/// 录音按钮点击事件
- (void)actionAddRecordButtonAction {
    
    [self.btnVoice addTarget:self action:@selector(actionHoldDownButtonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self.btnVoice addTarget:self action:@selector(actionHoldDownButtonTouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
    [self.btnVoice addTarget:self action:@selector(actionHoldDownButtonTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self.btnVoice addTarget:self action:@selector(actionHoldDownDragOutside) forControlEvents:UIControlEventTouchDragExit];
    [self.btnVoice addTarget:self action:@selector(actionHoldDownDragInside) forControlEvents:UIControlEventTouchDragEnter];
}

/// 开始录制
- (void)actionHoldDownButtonTouchDown {
    
//    NSLog(@"开始录制");
    
    [self.btnVoice updateRecordBuutonStyle:VoiceRecordStateStart];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecordState:)]) {
        [self.delegate chatToolBarVoiceRecordState:VoiceRecordStateStart];
    }
}

/// 取消了
- (void)actionHoldDownButtonTouchUpOutside {
    
//    NSLog(@"取消了");

    [self.btnVoice updateRecordBuutonStyle:VoiceRecordStateCanceled];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecordState:)]) {
        [self.delegate chatToolBarVoiceRecordState:VoiceRecordStateCanceled];
    }
}

/// 录制完成
- (void)actionHoldDownButtonTouchUpInside {
    
//    NSLog(@"录制完成");

    
    [self.btnVoice updateRecordBuutonStyle:VoiceRecordStateFinished];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecordState:)]) {
        [self.delegate chatToolBarVoiceRecordState:VoiceRecordStateFinished];
    }
}

/// 上滑
- (void)actionHoldDownDragOutside {
    
//    NSLog(@"上滑");

    [self.btnVoice updateRecordBuutonStyle:VoiceRecordStateTouchUpCancel];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecordState:)]) {
        [self.delegate chatToolBarVoiceRecordState:VoiceRecordStateTouchUpCancel];
    }
}

/// 继续录制
- (void)actionHoldDownDragInside {
    
//    NSLog(@"继续录制");

    [self.btnVoice updateRecordBuutonStyle:VoiceRecordStateStart];
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecordState:)]) {
        [self.delegate chatToolBarVoiceRecordState:VoiceRecordStateStart];
    }
}

#pragma mark- Item 事件监听
- (void)chatToolBarDidSelected:(ChatToolBarItem *)item isSelected:(BOOL)isSelected {
    if (item == self.itemVoice) {
        [self actionItemVoice:isSelected];
    } else if (item == self.itemMore) {
        [self actionItemMore:isSelected];
    }
}

/// voice事件
- (void)actionItemVoice:(BOOL)isSelected {
    
    self.viewInput.hidden = isSelected;
    self.btnVoice.hidden = !isSelected;
    
    [self.itemMore updateItemState:NO];
    
    if (isSelected) {
        [self.viewInput resignFirstResponder];
    } else {
        [self.viewInput becomeFirstResponder];
        _oldContentHeight = _originContentHeight;
        [self didReceiveTextDidChangeNotification];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarVoiceRecoredActionState:)]) {
            [self.delegate chatToolBarVoiceRecoredActionState:isSelected];
    }
}

/// 点击moreView
- (void)actionItemMore:(BOOL)isSelected {
    
    self.viewInput.hidden = NO;
    self.btnVoice.hidden = YES;
    [self.itemVoice updateItemState:NO];
    
    if (isSelected) {
        [self.viewInput resignFirstResponder];
    } else {
        [self.viewInput becomeFirstResponder];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarMoreViewActionState:)]) {
        [self.delegate chatToolBarMoreViewActionState:isSelected];
    }
}

#pragma mark- Public
///开始编辑
- (void)beginEditing {
    
    [self.viewInput becomeFirstResponder];
}

/// 点击空白时 需要复位当前的状态
- (void)resetState {
    [self.viewInput resignFirstResponder];
    [self.itemVoice updateItemState:NO];
    [self.itemMore updateItemState:NO];
    self.btnVoice.hidden = YES;
    self.viewInput.hidden = NO;
}

#pragma mark- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    _oldContentHeight = [self getTextViewContentH:textView];
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        NSString *str = textView.text;
        textView.text = @"";
        _oldContentHeight = [self getTextViewContentH:textView];
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarSendText:)]) {
            [self.delegate chatToolBarSendText:str];
        }
        return NO;
    }
    return YES;
}

@end
