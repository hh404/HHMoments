//
//  CommentOperationView.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "CommentOperationView.h"

@interface CommentOperationView ()
{
    UIButton *_likeButton;
    UIButton *_commentButton;
}
@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation CommentOperationView

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}

-(id)init
{
    if(self = [super init])
    {
        self.clipsToBounds = YES;//AlbumLike   AlbumComment
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor colorWithHex:0x454a4c];
        _likeButton = [self creatButtonWithTitle:NSLocalizedString(@"praise", nil) image:[UIImage imageNamed:@"dislike"] selImage:nil target:self selector:@selector(likeButtonClicked)];
        [self addSubview:_likeButton];
        _commentButton = [self creatButtonWithTitle:NSLocalizedString(@"comment", nil) image:[UIImage imageNamed:@"comment"] selImage:nil target:self selector:@selector(commentButtonClicked)];
        [self addSubview:_commentButton];
        UIView *centerLine = [UIView new];
        centerLine.backgroundColor = [UIColor grayColor];
        [self addSubview:centerLine];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(self).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(80);
        }];
        [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.left.mas_equalTo(_likeButton.mas_right).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(1);
        }];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(centerLine.mas_right).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(80);
        }];
        
    }
    return self;
}
- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}
-(void)setPraiseString:(NSString *)praiseString
{
    _praiseString = praiseString;
    [_likeButton setTitle:praiseString forState:UIControlStateNormal];
}
- (void)likeButtonClicked
{
    if(self.likeBtnClicked)
    {
        self.likeBtnClicked();
    }
    
}
- (void)commentButtonClicked
{
    if(self.commentBtnClicked)
    {
        self.commentBtnClicked();
    }
}
-(void)setIsShowing:(BOOL)isShowing
{
    _isShowing = isShowing;
    if(isShowing)
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(180);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
    else
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
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
#pragma mark Handlers

@end
