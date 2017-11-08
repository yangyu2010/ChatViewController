//
//  ChatToolBarMoreModel.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/2.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBarMoreModel.h"

@implementation ChatToolBarMoreModel

@end


@implementation ChatToolBarMoreViewModel

+ (NSArray *)getChatToolBarMoreModels {
    
    NSArray *arrTitles = @[@"照片", @"拍照", @"位置", @"红包", @"语言输入", @"个人名片", @"收藏", @"转账"];
    NSArray *arrIcons = @[@"sharemore_pic", @"sharemore_video", @"sharemore_location", @"sharemore_multitalk", @"sharemore_voiceinput", @"sharemore_friendcard", @"sharemore_myfav", @"sharemorePay", @"sharemore_wallet"];
    
    NSMutableArray *arrModels = [[NSMutableArray alloc] init];
    for (int i = 0; i < arrTitles.count; i ++) {
        ChatToolBarMoreModel *model = [[ChatToolBarMoreModel alloc] init];
        model.strTitle = arrTitles[i];
        model.strIconName = arrIcons[i];
        [arrModels addObject:model];
    }
    
    return arrModels.copy;
}

@end
