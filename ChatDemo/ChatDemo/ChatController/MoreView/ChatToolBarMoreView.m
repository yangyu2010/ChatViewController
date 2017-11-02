//
//  ChatToolBarMoreView.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/1.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "ChatToolBarMoreView.h"
#import "ChatToolBarMoreModel.h"
#import "ChatToolBarMoreCell.h"
#import "UIColor+Utils.h"

#define kChatToolBarMoreViewCellID @"kChatToolBarMoreViewCellID"

@interface ChatToolBarMoreView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionMore;

@property (nonatomic, strong) NSArray <ChatToolBarMoreModel *> *arrData;


@end

@implementation ChatToolBarMoreView

#pragma mark- Init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self viewConfig];
        [self dataConfig];
    }
    return self;
}


#pragma mark- UI

- (void)viewConfig {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionMore = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionMore.pagingEnabled = YES;
    self.collectionMore.showsVerticalScrollIndicator = NO;
    self.collectionMore.showsHorizontalScrollIndicator = NO;
    self.collectionMore.backgroundColor = [UIColor colorFromHexRGB:@"E8E8E8"];
    [self.collectionMore registerClass:[ChatToolBarMoreCell class] forCellWithReuseIdentifier:kChatToolBarMoreViewCellID];
    self.collectionMore.dataSource = self;
    self.collectionMore.delegate = self;
    [self addSubview:self.collectionMore];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.collectionMore.frame = self.bounds;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionMore.collectionViewLayout;
    
    CGFloat w = (self.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right) / 4;
    CGFloat h = self.bounds.size.height / 2;
    layout.itemSize = CGSizeMake(w, h);
    
    [self.collectionMore setCollectionViewLayout:layout];
    
}

#pragma mark- Data

- (void)dataConfig {
    
    self.arrData = [ChatToolBarMoreViewModel getChatToolBarMoreModels];
    
}

#pragma mark- DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChatToolBarMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChatToolBarMoreViewCellID forIndexPath:indexPath];
    [cell configUIWithModel:self.arrData[indexPath.item]];
    return cell;
}


@end
