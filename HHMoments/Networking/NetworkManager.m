//
//  NetworkManager.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager ()

@end

// Constants
// NSString * const NetworkManagerDidSomethingNotification = @"NetworkManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

static NetworkManager *gNetworkManager = nil;

@implementation NetworkManager

#pragma mark -
#pragma mark Static methods

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gNetworkManager = [[NetworkManager alloc] init];
    });
    return gNetworkManager;
}

#pragma mark -
#pragma mark Default

- (instancetype)init {
    if ((self = [super init])) {
    }
    return self;
}

- (void)dealloc {
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

- (void)requestUserInfoSuccess:(requestSuccess)success failure:(requestFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://thoughtworks-ios.herokuapp.com/user/jsmith" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             CurrentUserInfo *userInfo = [CurrentUserInfo mj_objectWithKeyValues:responseObject];
             NSLog(@"%@",userInfo);
             if(success)
             {
                 success(userInfo);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             failure(error);
         }];
}

- (void)requestMomentsSuccess:(requestSuccess)success failure:(requestFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://thoughtworks-ios.herokuapp.com/user/jsmith/tweets" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"这里打印请求成功要做的事");
             NSMutableArray *ar = [[OneMoment mj_objectArrayWithKeyValuesArray:responseObject] mutableCopy];
             
             //排错
             NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
             for (int i=0; i<[ar count]; i++) {
                 OneMoment *moment = [ar objectAtIndex:i];
                 if([moment.error length] > 0)
                 {
                     [set addIndex:i];
                 }
             }
             [ar removeObjectsAtIndexes:set];
             Monents *moments = [[Monents alloc] init];
             moments.comments = ar;
             NSLog(@"%@",ar);
             if(success)
             {
                 success(moments);
             }
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             failure(error);
         }];
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
