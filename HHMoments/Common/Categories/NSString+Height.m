//
//  NSString+Height.m
//  HHMoments
//
//  Created by huangjianwu on 2017/8/19.
//  Copyright © 2017年 huangjianwu. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)

/**
 根据文字多少计算高度
 */
+ (float)stringHeightWithString:(NSString *)string size:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
    
    float height = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return ceilf(height);
}

@end
