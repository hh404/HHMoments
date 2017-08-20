//
//  MomentsViewController.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentsViewController.h"
#import "MomentCell.h"
#import "MonmentHeadView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "NetworkManager.h"
#import "MomentsDataManager.h"

@interface MomentsViewController ()<UITableViewDelegate,UITableViewDataSource,MomentCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *moments;

@property (nonatomic,assign)NSUInteger pageNumber;

@property (nonatomic,assign)BOOL isNoMoreData;

@end

// Constants
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation MomentsViewController

#pragma mark -
#pragma mark Static methods

#pragma mark -
#pragma mark Init and dealloc

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNumber = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _setupTableView];
    [self _setupHeadView];
    self.title = NSLocalizedString(@"moments", nil);
    _isNoMoreData = NO;
    __weak MomentsViewController *wkSelf = self;
    [[NetworkManager shareManager] requestUserInfoSuccess:^(id response) {
        MonmentHeadView *hv = (MonmentHeadView*)wkSelf.tableView.tableHeaderView;
        hv.userInfo = response;
    } failure:^(NSError *error) {
        
    }];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    
}


#pragma mark -
#pragma mark Private methods

- (void)_setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[MomentCell class] forCellReuseIdentifier:@"MomentCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = 100;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
    }];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        self.isNoMoreData = NO;
        //[self updateData];
        [self _refresh];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
       // [self updateData];
        [self _loadMore];
    }];
    

}

- (void)_setupHeadView
{
    MonmentHeadView *headerView = [[MonmentHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240+64+20)];
    self.tableView.tableHeaderView = headerView;

}

- (void)_requestMomentsFromServer
{
        __weak MomentsViewController *wkSelf = self;
    [[NetworkManager shareManager] requestMomentsSuccess:^(id response) {
        wkSelf.moments = [response mutableCopy];
        [wkSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)_refresh
{

        __weak MomentsViewController *wkSelf = self;
        [[MomentsDataManager shareManager] momentsWithPageNumber:_pageNumber moments:^(id response) {
            wkSelf.moments = [response mutableCopy];
            [wkSelf.tableView reloadData];
            [[self.tableView mj_header] endRefreshing];
        } failure:^(NSError *error) {
            
        }];


}

- (void)_loadMore
{
    if(self.isNoMoreData)
    {
        [[self.tableView mj_footer] endRefreshing];
        //没有更多了
        return;
    }
    //if([self.tableView.mj_footer state] == MJRefreshStateIdle)
    {
        _pageNumber += 1;
        __weak MomentsViewController *wkSelf = self;
        [[MomentsDataManager shareManager] momentsWithPageNumber:_pageNumber moments:^(id response) {
            NSArray *momentArray = response;
            if(momentArray.count < 5)
            {
                wkSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                wkSelf.isNoMoreData = YES;
            }
            [wkSelf.moments addObjectsFromArray:response];
            [wkSelf.tableView reloadData];
            [[self.tableView mj_footer] endRefreshing];
        } failure:^(NSError *error) {
            
        }];
    }
}

#pragma mark -
#pragma mark Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MomentCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MomentCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configCellWithModel:[self.moments objectAtIndex:indexPath.row] indexPath:indexPath];
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h =  [MomentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MomentCell *cell = (MomentCell *)sourceCell;
        [cell configCellWithModel:[self.moments objectAtIndex:indexPath.row] indexPath:indexPath];
    }];
    return h;
    //return 320;
}

#pragma mark - 
#pragma mark Handlers

#pragma mark - 

#pragma mark -- MomentCellDelegate
#pragma mark -- 点击全文、收起
-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
{
    OneMoment *model = self.moments[indexPath.row];
    model.isExpand = !model.isExpand;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
/*#pragma mark -- 点击图片
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath
{
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageViewArray:array imageViewContainView:view];
    browser.selectedImageView = imageView;
    [browser show];
}
#pragma mark -- 点击赞
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath
{
    FriendLineCellModel *model = self.dataArray[indexPath.row];
    NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    model.isLiked ==YES ? [likeArray removeObject:@"Sky"]:[likeArray addObject:@"Sky"];
    
    model.likeNameArray = [likeArray copy];
    model.isLiked = !model.isLiked;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark -- 点击评论按钮
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath
{
    
    self.commentIndexpath = indexPath;
    FriendLineCellModel *model = self.dataArray[indexPath.row];
    self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论：%@",model.usernName];
    [self.chatKeyBoard keyboardUpforComment];
}
#pragma mark --点击评论内容的某一行
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
    FriendLineCellModel *model = self.dataArray[firIndexPath.row];
    CommentModel *comModel = model.commentArray[secIndexPath.row];
    if([comModel.userName isEqualToString:@"Sky"])
    {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil  message:@"是否删除该条评论" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *mutableArray = model.commentArray.mutableCopy;
            [mutableArray removeObjectAtIndex:secIndexPath.row];
            model.commentArray = mutableArray.copy;
            [self.tableView reloadRowsAtIndexPaths:@[firIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        [controller addAction:cancelAction];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        self.commentIndexpath = firIndexPath;
        self.replyIndexpath = secIndexPath;
        
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复：%@",comModel.userName];
        [self.chatKeyBoard keyboardUpforComment];
    }
    
}*/

@end
