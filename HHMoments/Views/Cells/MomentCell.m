//
//  MomentCell.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentCell.h"
#import "ImageGridView.h"

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface MomentCell ()
@property (nonatomic, strong) UIImageView *avatarImageView; //头像
@property (nonatomic, strong) UILabel *nameLabel; //名字
@property (nonatomic, strong) UILabel *contentLabel; //内容
@property(nonatomic,strong) ImageGridView *imageGridView;
@property (nonatomic, strong) UIButton *moreButton; //收起展开按钮

@property (nonatomic, strong) UIButton *operationButton;  //点赞评论按钮
@property (nonatomic, strong) UILabel *timeLabel; //时间

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
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
            make.left.equalTo(self.self.contentLabel.mas_left); //with is an optional semantic filler
            make.top.equalTo(self.contentLabel.mas_top);
            make.width.equalTo(@30);
            make.height.equalTo(@40);
        }];
    }
    
    return _timeLabel;
}

- (UIButton *)operationButton
{
    if (!_operationButton) {
        
        _operationButton = [UIButton new];
        
        [self.contentView addSubview:_operationButton];
        
        [_operationButton addTarget:self action:@selector(operationClicked:) forControlEvents:UIControlEventTouchUpInside];
        
//        _operationButton.sd_layout
//        .rightSpaceToView(self.contentView, 10)
//        .centerYEqualToView(_timeLabel)
//        .heightIs(25)
//        .widthIs(25);
    }
    
    return _operationButton;
}

#pragma mark -
#pragma mark Public methods

- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath;
{
    self.model = model;
    self.indexPath = indexPath;
    self.avatarImageView.image = [UIImage imageNamed:model.sender.avatar];
    self.nameLabel.text = model.sender.username;
    self.contentLabel.text = model.content;
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
//    self.imageViewContainView.model = model;
//    [self.commentView configCellWithModel:model indexPath:indexPath];
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


#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
