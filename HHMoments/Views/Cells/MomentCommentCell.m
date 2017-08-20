//
//  MomentCommentCell.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MLLinkLabel.h"


@interface MomentCommentCell ()<MLLinkLabelDelegate>

@property (nonatomic, strong) MLLinkLabel *contentLabel;

@end

// Constants
// NSString * const MomentCommentCellDidSomethingNotification = @"MomentCommentCellDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation MomentCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.contentLabel = [[MLLinkLabel alloc] init];
        self.contentLabel.delegate = self;
        self.contentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:92/255.0 green:140/255.0 blue:255/255.0 alpha:1.0]};
        self.contentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
        [self.contentView addSubview:self.contentLabel];
        
        
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:14.0];
        
        
        self.contentLabel.preferredMaxLayoutWidth = kScreenWidth-80;
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView).offset(0);
        }];
        
        
        self.hyb_lastViewInCell = self.contentLabel;
        self.hyb_bottomOffsetToCell = 5.0;
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

- (void)setComment:(Comment *)comment
{
    _comment = comment;
    
    NSString *string =[NSString stringWithFormat:@"%@：%@",comment.sender.username,comment.content];

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text setAttributes:@{NSLinkAttributeName : comment.sender.username} range:[string rangeOfString:comment.sender.username]];
    self.contentLabel.attributedText = text;
}

#pragma mark -
#pragma mark Public methods



#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel
{
    NSLog(@"点击了：%@",link.linkValue);
}

@end
