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
        [self _setupCollectionView];
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
    ly.minimumLineSpacing = 4;
    ly.minimumInteritemSpacing = 4;
    self.collectionView.collectionViewLayout = ly;
    
}

#pragma mark -
#pragma mark Properties

- (void)setImages:(NSArray *)images
{
    _images = images;
//    float heightAndWidth = (kScreenWidth - 80 - 10)/3;
//    float w =  heightAndWidth*images.count;
//    if(w > 2)
//    {
//        w = CGRectGetWidth(self.bounds);
//    }
//    else if (w > 1)
//    {
//        w += 10*2;
//    }
//    else
//    {
//        w += 10;
//    }
//    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.equalTo(self);
//        make.width.equalTo(@(w));
//    }];

    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

- (void)_setupCollectionView
{
    UICollectionViewFlowLayout *ly = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:ly];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[SingleImageViewCell class] forCellWithReuseIdentifier:@"SingleImageViewCell"];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(self);
    }];
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
    cell.backgroundColor = [UIColor RandomColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *dic = [self.images objectAtIndex:indexPath.item];
        [[ImageManager shareManager] imageWithURL:[dic objectForKey:@"url"] success:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = image;
            });
        } failure:^(NSError *error) {
            
        }];
    });

    
    return cell;
}

@end
