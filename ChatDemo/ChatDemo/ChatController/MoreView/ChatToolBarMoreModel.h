//
//  ChatToolBarMoreModel.h
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/2.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatToolBarMoreModel : NSObject

@property (nonatomic, copy) NSString *strIconName;

@property (nonatomic, copy) NSString *strTitle;

@end


@interface ChatToolBarMoreViewModel : NSObject

+ (NSArray *)getChatToolBarMoreModels;

@end
