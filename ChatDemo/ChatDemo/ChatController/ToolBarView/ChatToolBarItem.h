//
//  ChatToolBarItem.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/10/31.
//  Copyright © 2017年 Musjoy. All rights reserved.
//  底部toolbar中的每一个item

#import <UIKit/UIKit.h>

@class ChatToolBarItem;

@protocol ChatToolBarItemDelegate <NSObject>

- (void)chatToolBarDidSelected:(ChatToolBarItem *)item isSelected:(BOOL)isSelected;

@end



@interface ChatToolBarItem : UIView

/// 初始化
- (instancetype)initWithIconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName;

/// 更新当前item的状态
- (void)updateItemState:(BOOL)isSelected;

@property (nonatomic, weak) id <ChatToolBarItemDelegate> delegate;

@end
