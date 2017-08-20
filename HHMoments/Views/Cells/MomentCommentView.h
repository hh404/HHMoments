//
//  MomentCommentView.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/20.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import UIKit;
@protocol CommentViewDelegate <NSObject>

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end

@interface MomentCommentView : UIView

@property (nonatomic,weak) id <CommentViewDelegate>delegate;

- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath;

@end
