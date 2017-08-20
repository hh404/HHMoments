//
//  MomentsDataManager.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "MomentsDataManager.h"

@interface MomentsDataManager ()

@property(nonatomic,strong)NSMutableArray *moments;

@end

// Constants
// NSString * const MomentsDataManagerDidSomethingNotification = @"MomentsDataManagerDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

static MomentsDataManager *gMomentsDataManager = nil;

@implementation MomentsDataManager

#pragma mark -
#pragma mark Static methods

+ (instancetype)shareManager;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gMomentsDataManager = [[MomentsDataManager alloc] init];
    });
    return gMomentsDataManager;
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

- (void)momentsWithPageNumber:(NSUInteger)page moments:(requestSuccess)success failure:(requestFailure)failure;
{
    if((self.moments.count == 0) || (page == 1))
    {
        __weak MomentsDataManager *wkSelf = self;
        [[NetworkManager shareManager] requestMomentsSuccess:^(id response) {
            Monents *m = response;
            wkSelf.moments = [m.comments mutableCopy];
            //拆分5个一页
            NSRange range;
            range.location = 0;
            range.length = 5;
            if([m.comments count] < 5)
            {
                range.length = m.comments.count;
            }
            success([wkSelf.moments subarrayWithRange:range]);
            //success(wkSelf.moments);
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        //剩余
        __weak MomentsDataManager *wkSelf = self;
        NSRange range;
        range.location = (page - 1)*5;
        range.length = 5;
        if([wkSelf.moments count] < page*5)
        {
            range.length = (wkSelf.moments.count - (page-1)*5);
        }
        success([wkSelf.moments subarrayWithRange:range]);
    }
}

#pragma mark -
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
