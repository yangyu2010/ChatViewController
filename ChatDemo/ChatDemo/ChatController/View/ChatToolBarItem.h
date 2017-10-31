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

- (void)chatToolBarDidSelected:(ChatToolBarItem *)item;

@end



@interface ChatToolBarItem : UIView

- (instancetype)initWithIconName:(NSString *)iconName;

@property (nonatomic, weak) id <ChatToolBarItemDelegate> delegate;

@end
