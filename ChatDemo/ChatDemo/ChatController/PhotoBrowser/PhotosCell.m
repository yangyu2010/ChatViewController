//
//  PhotosCell.m
//  ChatDemo
//
//  Created by Yu Yang on 2017/11/26.
//  Copyright © 2017年 Musjoy. All rights reserved.
//

#import "PhotosCell.h"
#import "PhotoLoadingView.h"
#import <UIImageView+WebCache.h>

@interface PhotosCell ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) PhotoLoadingView *loadingView;

@end

@implementation PhotosCell

#pragma mark- Get

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (PhotoLoadingView *)loadingView {
    if (_loadingView == nil) {
        _loadingView = [[PhotoLoadingView alloc] init];
        _loadingView.hidden = YES;
    }
    return _loadingView;
}

#pragma mark- Set
- (void)setModel:(PhotoModel *)model {
    _model = model;
    
    self.loadingView.hidden = NO;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageURLString] placeholderImage:model.placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.loadingView.progress = receivedSize / (CGFloat)expectedSize;
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.loadingView.hidden = YES;
    }];
}

#pragma mark- Init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewConfig];
    }
    return self;
}


#pragma mark- UI

- (void)viewConfig {
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.contentView addSubview:self.loadingView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.contentView.bounds;

    self.loadingView.bounds = CGRectMake(0, 0, 50, 50);
    self.loadingView.center = self.contentView.center;
}

#pragma mark- Data

- (void)dataConfig {
    
}


@end
