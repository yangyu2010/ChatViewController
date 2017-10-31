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

@interface ChatToolBar () <UITextViewDelegate>
{
    
    CGFloat _oldContentHeight;
}
/// 语音item
@property (nonatomic, strong) ChatToolBarItem *itemVoice;

/// 表情item
@property (nonatomic, strong) ChatToolBarItem *itemFace;

/// 更多item
@property (nonatomic, strong) ChatToolBarItem *itemMore;

/// 输入框
@property (nonatomic, strong) ChatToolInputView *viewInput;


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
    self.itemVoice = [[ChatToolBarItem alloc] initWithIconName:@"voice"];
    [self addSubview:self.itemVoice];
    
    self.itemFace = [[ChatToolBarItem alloc] initWithIconName:@"face"];
    [self addSubview:self.itemFace];
    
    self.itemMore = [[ChatToolBarItem alloc] initWithIconName:@"multiMedia"];
    [self addSubview:self.itemMore];
    
    self.viewInput = [[ChatToolInputView alloc] init];
    [self addSubview:self.viewInput];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemH = self.bounds.size.height;
    CGFloat itemW = 35.0;
    
    self.itemVoice.frame = CGRectMake(0, 0, itemW, itemH);
    self.itemMore.frame = CGRectMake(self.bounds.size.width - itemW, 0, itemW, itemH);
    self.itemFace.frame = CGRectMake(self.bounds.size.width - itemW * 2, 0, itemW, itemH);
    self.viewInput.frame = CGRectMake(itemW + 3, 8, self.bounds.size.width - itemW * 3 - 6, itemH - 16);
}

#pragma mark- Data

- (void)dataConfig {
    
    self.viewInput.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark- Text View 相关

- (void)didReceiveTextDidChangeNotification:(NSNotification *)notification {
    
    CGFloat currentHeight = [self getTextViewContentH:self.viewInput];
    
    if (currentHeight == _oldContentHeight) {
        return ;
    }
    
    if ([self getTextViewLineCount:self.viewInput] >= 3) {
        
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

#pragma mark- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {

    _oldContentHeight = [self getTextViewContentH:textView];
    
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatToolBarSendText:)]) {
            [self.delegate chatToolBarSendText:textView.text];
        }
        textView.text = @"";
        _oldContentHeight = [self getTextViewContentH:textView];
        return NO;
    }
    return YES;
}

@end
