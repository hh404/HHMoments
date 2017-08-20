//
//  ImageGridView.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "ImageGridView.h"
#import "SingleImageViewCell.h"

@interface ImageGridView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation ImageGridView

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

- (void)dealloc {
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UICollectionViewFlowLayout *ly = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    float heightAndWidth = (kScreenWidth - 80 - 10)/3;
    ly.itemSize = CGSizeMake(heightAndWidth, heightAndWidth);
    ly.minimumLineSpacing = 10;
    ly.minimumInteritemSpacing = 10;
    self.collectionView.collectionViewLayout = ly;
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

- (void)_setupCollectionView
{
    UICollectionViewFlowLayout *ly = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:ly];
    [_collectionView registerClass:[SingleImageViewCell class] forCellWithReuseIdentifier:@"SingleImageViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
}

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Handlers

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    SingleImageViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"SingleImageViewCell" forIndexPath:indexPath];
    
    return cell;
}

@end
