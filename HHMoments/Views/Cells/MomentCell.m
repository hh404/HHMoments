//
//  MomentCell.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentCell.h"
#import "ImageGridView.h"
#import "MomentCommentView.h"
#import "CommentOperationView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"


CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface MomentCell ()
@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nameLabel; //名字
@property (nonatomic, strong) UILabel *contentLabel; //内容
@property(nonatomic,strong) ImageGridView *imageGridView;
@property (nonatomic, strong) UIButton *moreButton; //收起展开按钮
@property (nonatomic, strong) UIButton *operationButton;  //点赞评论按钮
@property (nonatomic, strong) UILabel *timeLabel; //时间
@property (nonatomic, strong) CommentOperationView *operationView;
@property (nonatomic,strong) MomentCommentView *commentView;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end

// Constants
// NSString * const MomentCellDidSomethingNotification = @"MomentCellDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation MomentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self _setup];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
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

#pragma mark - getter

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView)
    {
        _avatarImageView = [UIImageView new];
        [self.contentView addSubview:_avatarImageView];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = 20.0f;
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
//        _avatarImageView.sd_layout.leftSpaceToView(self.contentView, 15)
//        .topSpaceToView(self.contentView, 15)
//        .widthIs(40)
//        .heightIs(40);
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15); //with is an optional semantic filler
            make.left.equalTo(self.contentView).offset(15);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
    }
    
    return _avatarImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
//        _nameLabel.sd_layout
//        .leftSpaceToView(_avatar, 10)
//        .topEqualToView(_avatar)
//        .heightIs(18);
//        [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).offset(10); //with is an optional semantic filler
            make.top.equalTo(self.avatarImageView.mas_top);
            make.width.equalTo(@200);
            make.height.equalTo(@18);
        }];
    }
    
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [UILabel new];
        [self.contentView addSubview:_contentLabel];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.numberOfLines = 0;
        if (maxContentLabelHeight == 0) {
            maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
        }
//        _contentLabel.sd_layout
//        .leftEqualToView(_nameLabel)
//        .topSpaceToView(_nameLabel, 10)
//        .rightSpaceToView(self.contentView, 10)
//        .autoHeightRatio(0);
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.self.nameLabel.mas_left); //with is an optional semantic filler
            make.top.equalTo(self.nameLabel.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.height.equalTo(@58);
        }];
    }
    
    return _contentLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton)
    {
        _moreButton = [UIButton new];
        [self.contentView addSubview:_moreButton];
        [_moreButton setTitle:NSLocalizedString(@"fullText", nil) forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
//        _moreButton.sd_layout
//        .leftEqualToView(_contentLabel)
//        .topSpaceToView(_contentLabel, 0)
//        .widthIs(30);
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.self.contentLabel.mas_left); //with is an optional semantic filler
            make.top.equalTo(self.contentLabel.mas_top);
            make.width.equalTo(@30);
            make.height.equalTo(@40);
        }];
    }
    
    return _moreButton;
    
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        
        _timeLabel = [UILabel new];
        
        _timeLabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:_timeLabel];
        
//        _timeLabel.sd_layout
//        .leftEqualToView(_contentLabel)
//        .topSpaceToView(_picContainerView, 10)
//        .heightIs(15);
//        [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentLabel.mas_left); //with is an optional semantic filler
            make.top.equalTo(self.imageGridView.mas_bottom).offset(10);
            make.width.equalTo(@200);
            make.height.equalTo(@15);
        }];
    }
    
    return _timeLabel;
}

- (UIButton *)operationButton
{
    if (!_operationButton) {
        
        _operationButton = [UIButton new];
        
        [self.contentView addSubview:_operationButton];
        
        [_operationButton setBackgroundImage:[UIImage imageNamed:@"operateMore"] forState:UIControlStateNormal];
        [_operationButton addTarget:self action:@selector(operationBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
//        _operationButton.sd_layout
//        .rightSpaceToView(self.contentView, 10)
//        .centerYEqualToView(_timeLabel)
//        .heightIs(25)
//        .widthIs(25);
        
        [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-10); //with is an optional semantic filler
            make.centerY.equalTo(self.timeLabel.mas_centerY);
            make.width.equalTo(@25);
            make.height.equalTo(@25);
        }];
    }
    
    return _operationButton;
}

- (ImageGridView *)imageGridView
{
    if(!_imageGridView)
    {
        _imageGridView = [[ImageGridView alloc] init];
        _imageGridView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_imageGridView];
    }
    return _imageGridView;
}

- (CommentOperationView *)operationView
{
    if(!_operationView)
    {
        _operationView = [[CommentOperationView alloc] init];
        [self.contentLabel addSubview:_operationView];
        
        
        //_operationView.backgroundColor = [UIColor greenColor];
        [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageGridView.mas_bottom).offset(10);
            make.right.mas_equalTo(self.operationButton.mas_left).offset(-5);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        __weak typeof(self) weakSelf = self;
        [_operationView setLikeBtnClicked:^{
            weakSelf.operationView.isShowing = NO;
//            if([weakSelf.delegate respondsToSelector:@selector(didClickenLikeBtnWithIndexPath:)])
//            {
//                [weakSelf.delegate didClickenLikeBtnWithIndexPath:weakSelf.indexPath];
//            }
        }];
        [_operationView setCommentBtnClicked:^{
            weakSelf.operationView.isShowing = NO;
//            if([weakSelf.delegate respondsToSelector:@selector(didClickCommentBtnWithIndexPath:)])
//            {
//                [weakSelf.delegate didClickCommentBtnWithIndexPath:weakSelf.indexPath];
//            }
        }];
        
       // [_operationView addTarget:self action:@selector(operationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationView;
}

- (MomentCommentView *)commentView
{
    if(!_commentView)
    {
        _commentView = [[MomentCommentView alloc] init];
        [self.contentView addSubview:_commentView];
    }
    
    //赞 评论的View
//    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.operationView.mas_bottom).offset(5);
//        make.left.right.mas_equalTo(self.contentLabel);
//        
//    }];
    
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.operationView.mas_bottom).offset(5);
        make.right.left.mas_equalTo(self.contentLabel);
    }];
    
    self.hyb_lastViewInCell = _commentView;
    self.hyb_bottomOffsetToCell = 10;
    return _commentView;
}

#pragma mark -
#pragma mark Public methods

- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath;
{
    self.model = model;
    self.indexPath = indexPath;
    //[self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.sender.avatar]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[ImageManager shareManager] imageWithURL:model.sender.avatar success:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.avatarImageView.image = image;
            });
        } failure:^(NSError *error) {
            
        }];
    });
    self.model.comments = [Comment mj_objectArrayWithKeyValuesArray:self.model.comments];
    self.nameLabel.text = model.sender.username;
    self.contentLabel.text = model.content;
    self.timeLabel.text = [NSString stringWithFormat:@"%d%@",arc4random()%30+1,NSLocalizedString(@"minutesAgo", nil)];
//    // self.imageViewContainView.model = model;
    float msgHeight = [HHTools heightWithString:model.content size:15 maxWidth: kScreenWidth-80];
    if(msgHeight <=60)
    {
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.contentLabel);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    else
    {
        [self.moreButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.contentLabel);
        }];
    }
    if(model.isExpand)
    {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(msgHeight);
        }];
    }
    else
    {
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(60);
        }];
    }
    self.moreButton.selected = model.isExpand;
    CGSize imageContainViewSize;
    if(model.images.count==0)
    {
        imageContainViewSize = CGSizeMake(0, 0);
    }
    else if (model.images.count>0 && model.images.count<4)
    {
        imageContainViewSize = CGSizeMake(kScreenWidth-80, (kScreenWidth-80-10)/3);
    }
    else
    {
        imageContainViewSize = CGSizeMake(kScreenWidth-80,(2*(kScreenWidth-90)/3)+5);
    }
    [self.imageGridView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreButton.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.moreButton);
        make.size.mas_equalTo(imageContainViewSize);
    }];
    self.imageGridView.images = model.images;
    self.operationButton;
    [self.commentView configCellWithModel:model indexPath:indexPath];
    self.operationView.isShowing = NO;
}

#pragma mark - 
#pragma mark Private methods

- (void)_setup
{
    self.avatarImageView.image = [UIImage imageNamed:@""];
    
    self.nameLabel.text = @"";
    
    self.contentLabel.text = @"";
    
    //self.moreButton.sd_layout.heightIs(0);
    
    //self.picContainerView.picPathStringsArray = @[];
    
    self.timeLabel.text = @"";
    
    [self.operationButton setImage:[UIImage imageNamed:@"OperateMore"] forState:UIControlStateNormal];
    
    //self.operationMenu.backgroundColor = [UIColor colorWithRed:69/255.0 green:74/255.0 blue:76/255.0 alpha:1.0];
    
}

-(void)operationBtnClick
{
    //self.operationView.praiseString = @"赞";
    self.operationView.isShowing = !self.operationView.isShowing;
}

-(void)moreButtonClicked:(UIButton *)sender
{
    if(_model.isExpand)
    {
        [_moreButton setTitle:NSLocalizedString(@"fullText", nil) forState:UIControlStateNormal];
    }
    else
    {
        [_moreButton setTitle:NSLocalizedString(@"expand", nil) forState:UIControlStateNormal];
    }
    if([_delegate respondsToSelector:@selector(didClickedMoreBtn:indexPath:)])
    {
        [_delegate didClickedMoreBtn:sender indexPath:self.indexPath];
    }
}

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
