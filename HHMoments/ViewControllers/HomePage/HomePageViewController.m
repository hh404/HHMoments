//
//  HomePageViewController.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/16.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "HomePageViewController.h"
#import "MomentsViewController.h"
#import "NetworkManager.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setupMomentsButton];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Action

- (void)_setupMomentsButton
{
    UIButton *momentsBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    momentsBtn.backgroundColor = [UIColor blueColor];
    [momentsBtn setTitle:NSLocalizedString(@"moments", nil) forState:UIControlStateNormal];
    [momentsBtn addTarget:self action:@selector(_startMoments:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:momentsBtn];
    

    UIEdgeInsets padding = UIEdgeInsetsMake(100, 100, 10, 100);
    
    [momentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.height.equalTo(@40);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];
}

- (void)_startMoments:(UIButton*)sender{
    MomentsViewController *mc = [[MomentsViewController alloc] init];
    [self.navigationController pushViewController:mc animated:YES];
}


@end
