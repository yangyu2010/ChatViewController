//
//  PhotoBrowserController.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotosCell.h"

#define kPhotoBrowserCellID  @"kPhotoBrowserCellID"

@interface PhotoBrowserController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *_arrPhotos;
    NSInteger _index;
}

@property (nonatomic, strong) UICollectionView *collectionViewPhotos;


@end

@implementation PhotoBrowserController


#pragma mark- Get
- (UICollectionView *)collectionViewPhotos {
    if (_collectionViewPhotos == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionViewPhotos = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionViewPhotos.showsHorizontalScrollIndicator = NO;
        _collectionViewPhotos.pagingEnabled = YES;
        
        _collectionViewPhotos.delegate = self;
        _collectionViewPhotos.dataSource = self;
        [_collectionViewPhotos registerClass:[PhotosCell class] forCellWithReuseIdentifier:kPhotoBrowserCellID];
    }
    return _collectionViewPhotos;
}

#pragma mark- Init
- (instancetype)initWithPhotos:(NSArray <PhotoModel *> *)arrPhotos
                         index:(NSInteger)index {
    
    self = [super init];
    if (self) {
        
        _arrPhotos = arrPhotos;
        _index = index;
        
    }
    return self;
}

#pragma mark- Life circle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewConfig];
    
}



#pragma mark- UI

- (void)viewConfig {
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.collectionViewPhotos];
    [self.collectionViewPhotos reloadData];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 20, 80, 30);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"Close" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.collectionViewPhotos.frame = self.view.bounds;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewPhotos.collectionViewLayout;
    layout.itemSize = self.view.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [self.collectionViewPhotos setCollectionViewLayout:layout];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.collectionViewPhotos scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark- Data

- (void)dataConfig {
    
}

#pragma mark- Action

- (void)btnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _arrPhotos.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotosCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoBrowserCellID forIndexPath:indexPath];
    cell.model = _arrPhotos[indexPath.item];
    return cell;
}

@end
