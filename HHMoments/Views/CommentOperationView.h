//
//  CommentOperationView.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import UIKit;

@interface CommentOperationView : UIView
@property (nonatomic,assign)BOOL isShowing;
@property (nonatomic,copy)void (^commentBtnClicked)();
@property (nonatomic,copy)void (^likeBtnClicked)();
@property (nonatomic,copy)NSString *praiseString;
@end
