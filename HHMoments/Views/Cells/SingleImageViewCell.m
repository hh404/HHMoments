//
//  SingleImageViewCell.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "SingleImageViewCell.h"

@interface SingleImageViewCell ()

@end

// Constants
// NSString * const SingleImageViewCellDidSomethingNotification = @"SingleImageViewCellDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation SingleImageViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top); //with is an optional semantic filler
            make.left.equalTo(self.contentView.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.right.equalTo(self.contentView.mas_right);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
