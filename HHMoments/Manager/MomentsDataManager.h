//
//  MomentsDataManager.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;
#import "NetworkManager.h"

@interface MomentsDataManager : NSObject

+ (instancetype)shareManager;

- (void)momentsWithPageNumber:(NSUInteger)page moments:(requestSuccess)success failure:(requestFailure)failure;

@end
