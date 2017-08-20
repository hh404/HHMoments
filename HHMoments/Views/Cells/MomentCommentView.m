//
//  MomentCommentView.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentCommentView.h"
#import "MomentCommentCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MLLinkLabel.h"

@interface MomentCommentView ()<UITableViewDelegate,UITableViewDataSource,MLLinkLabelDelegate>
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)UIImageView *bigImageView;
@property (nonatomic,strong)MLLinkLabel *praiseLabel;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation MomentCommentView

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

-(id)init
{
    if(self = [super init])
    {
        //        self.commentDataArray = @[].mutableCopy;
        //        self.likeArray = @[].mutableCopy;
        //        UIImageView *bigImageView = [[UIImageView alloc] init];
        //        UIImage *bgImage = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        //        bigImageView.image = bgImage;
        //        [self addSubview:bigImageView];
        //        self.bigImageView = bigImageView;
        self.backgroundColor = [UIColor clearColor];

        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[MomentCommentCell class] forCellReuseIdentifier:@"MomentCommentCell"];
        tableView.scrollEnabled = NO;
        tableView.estimatedRowHeight = 44.0;
        //tableView.rowHeight = UITableViewAutomaticDimension;

        [self addSubview:tableView];
        self.tableView = tableView;
        //        [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.top.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        //        }];
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=  [MomentCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MomentCommentCell *cell = (MomentCommentCell *)sourceCell;
        cell.comment = self.commentDataArray[indexPath.row];
        //[cell configCellWithModel:self.commentDataArray[indexPath.row]];
    } ];
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MomentCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MomentCommentCell"];
    cell.backgroundColor = [UIColor colorWithHex:0xf0f0f0];
    //[cell configCellWithModel:self.commentDataArray[indexPath.row]];
    [cell setComment:self.commentDataArray[indexPath.row]];
   // cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)])
    {
        [_delegate didClickRowWithFirstIndexPath:self.indexPath secondIndex:indexPath];
    }
}
- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath
{
    self.commentDataArray = [NSMutableArray arrayWithArray:model.comments];
    self.indexPath = indexPath;
    [self.tableView reloadData];
    float height = 0.0;
    for(Comment *model in self.commentDataArray)
    {
        float cellHeight = [MomentCommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            MomentCommentCell *cell = (MomentCommentCell *)sourceCell;
            [cell setComment:model];
        }];
        height += cellHeight;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
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

#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel
{
    NSLog(@"点击了：%@",link.linkValue);
}

@end
