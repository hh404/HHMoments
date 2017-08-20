//
//  ImageManager.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

typedef void(^success)(UIImage *image);
typedef void(^failure)(NSError *error);

@interface ImageManager : NSObject

+ (instancetype)shareManager;

- (void)imageWithURL:(NSString*)url success:(success)successBlock failure:(failure)failureBlock;

@end
