//
//  OpinionCell.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OpinionModel;
@interface OpinionCell : UITableViewCell
@property(nonatomic,strong)OpinionModel *opinionModel;
/**获取cell高度*/
+(CGFloat)getOpinionCellHeightWithModel:(OpinionModel *)model;
@end
