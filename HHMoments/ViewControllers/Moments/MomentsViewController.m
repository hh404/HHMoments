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

@interface MomentsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)Monents *moments;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _setupTableView];
    [self _setupHeadView];
    self.title = NSLocalizedString(@"moments", nil);
    
    __weak MomentsViewController *wkSelf = self;
    [[NetworkManager shareManager] requestUserInfoSuccess:^(id response) {
        MonmentHeadView *hv = (MonmentHeadView*)wkSelf.tableView.tableHeaderView;
        hv.userInfo = response;
    } failure:^(NSError *error) {
        
    }];
    [[NetworkManager shareManager] requestMomentsSuccess:^(id response) {
        wkSelf.moments = response;
        [wkSelf.tableView reloadData];
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
}

- (void)_setupHeadView
{
    MonmentHeadView *headerView = [[MonmentHeadView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240+64+20)];
    self.tableView.tableHeaderView = headerView;

}

#pragma mark -
#pragma mark Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.moments.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MomentCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"MomentCell"];
    [cell configCellWithModel:[self.moments.comments objectAtIndex:indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    float h =  [MomentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//        MomentCell *cell = (MomentCell *)sourceCell;
//        [cell configCellWithModel:[self.moments.comments objectAtIndex:indexPath.row] indexPath:indexPath];
//    }];
    return 80;
}

#pragma mark - 
#pragma mark Handlers

@end
