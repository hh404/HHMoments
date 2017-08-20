//
//  MonmentHeadView.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MonmentHeadView.h"
#import "UIImageView+WebCache.h"

@interface MonmentHeadView ()

@property(nonatomic,strong)UIImageView *backgroundImageView;
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation MonmentHeadView

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        
        self.backgroundColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.image = [UIImage imageNamed:@"pbg.jpg"];
        [self addSubview:_backgroundImageView];
        _backgroundImageView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, frame.size.height-64-20);
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-20, kScreenWidth, 20)];
        whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:whiteView];
        
        _avatarImageView = [UIImageView new];
        _avatarImageView.frame = CGRectMake(kScreenWidth-100, frame.size.height-80, 80, 80);
        _avatarImageView.image = [UIImage imageNamed:@"icon1.jpg"];
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImageView.layer.borderWidth = 2;
        [self addSubview:_avatarImageView];
        
        _nameLabel = [UILabel new];
        _nameLabel.frame = CGRectMake(kScreenWidth-220, _avatarImageView.frame.origin.y+20, 100, 30);
        _nameLabel.text = @"Sky";
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentRight;
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

-(void)setUserInfo:(CurrentUserInfo *)userInfo
{
    _userInfo = userInfo;
    [_backgroundImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.profileImage]];
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar]];
    _nameLabel.text = userInfo.nick;
}

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Handlers

@end
