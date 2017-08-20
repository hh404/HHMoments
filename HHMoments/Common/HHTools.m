//
//  HHTools.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "HHTools.h"

@interface HHTools ()

@end

// Constants
// NSString * const HHToolsDidSomethingNotification = @"HHToolsDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation HHTools

#pragma mark -
#pragma mark Static methods

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

/**
 根据文字多少计算高度
 */
+ (float)heightWithString:(NSString *)string size:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
    
    float height = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return ceilf(height);
}

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
