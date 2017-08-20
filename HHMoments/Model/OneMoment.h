//
//  OneMoment.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface OneMoment : NSObject

@property(nonatomic,strong)NSString *content;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)UserInfo *sender;

@property(nonatomic,strong)NSArray<Comment*> *comments;

@property(nonatomic,assign)BOOL isExpand;

@property(nonatomic,strong)NSString *error;

@end
