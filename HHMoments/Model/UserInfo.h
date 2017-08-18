//
//  UserInfo.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/16.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

/**
 用户信息基类
 */
@interface UserInfo : NSObject

/**
 头像
 */
@property(nonatomic,copy) NSString *avatar;

/**
 昵称
 */
@property(nonatomic,copy) NSString *nick;

/**
 用户名
 */
@property(nonatomic,copy) NSString *username;

@end
