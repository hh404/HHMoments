//
//  Comment.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface Comment : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,strong)UserInfo *sender;

@end
