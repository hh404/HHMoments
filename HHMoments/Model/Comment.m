//
//  Content.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

#import "Comment.h"

@interface Comment ()

@end

// Constants
// NSString * const ContentDidSomethingNotification = @"ContentDidSomething";
// static NSString * const kSomeLocalConstant = @"SomeValue";

@implementation Comment

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

- (NSString *)description
{
    return [self autoDescription];
}

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Public methods

#pragma mark - 
#pragma mark Private methods

#pragma mark - 
#pragma mark Delegate methods

#pragma mark - 
#pragma mark Event handlers

@end
