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

/// CollectionView
@property (nonatomic, strong) UICollectionView *collectionMore;

/// 数据源
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
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
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
    
    CGFloat width = 60;
    CGFloat height = 100;
    
    CGFloat margin = (self.bounds.size.width - 4 * width) / 5;
    layout.minimumInteritemSpacing = margin;
    layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    
    layout.itemSize = CGSizeMake(width, height);
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
