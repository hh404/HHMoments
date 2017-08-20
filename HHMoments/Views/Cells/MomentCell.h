//
//  MomentCell.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;

@interface MomentCell : UITableViewCell

@property(nonatomic,strong)OneMoment *model;

- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath;

@end
