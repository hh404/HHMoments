//
//  MomentCell.h
//  HHMoments
//
//  Created by huangjianwu on 2017/8/18.
//  Copyright (c) 2017年 huangjianwu. All rights reserved.
//

@import Foundation;


@protocol MomentCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;

-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;

-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath;

-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath;

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end

@interface MomentCell : UITableViewCell

@property(nonatomic,strong)OneMoment *model;

@property (nonatomic,weak)id<MomentCellDelegate> delegate;

- (void)configCellWithModel:(OneMoment *)model indexPath:(NSIndexPath *)indexPath;

@end
