//
//  NetworkManager.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

typedef void(^requestSuccess)(id response);
typedef void(^requestFailure)(NSError *error);

@interface NetworkManager : NSObject

+ (instancetype)shareManager;

- (void)requestUserInfoSuccess:(requestSuccess)success failure:(requestFailure)failure;

- (void)requestMomentsSuccess:(requestSuccess)success failure:(requestFailure)failure;


@end
