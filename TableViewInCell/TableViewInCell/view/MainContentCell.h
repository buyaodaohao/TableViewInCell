//
//  MainContentCell.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommenModel;
@protocol  MainContentCellDelegate<NSObject>

-(void)reloadCellHeightForModel:(CommenModel *)model tableViewHeight :(CGFloat)tableViewH atIndexPath:(NSIndexPath *)indexPath;

@end
@interface MainContentCell : UITableViewCell
@property(nonatomic,strong)CommenModel *contentModel;
@property(nonatomic,weak)id<MainContentCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
/**获取cell高度*/
+(CGFloat)getCommenListCellHeightFromModel:(CommenModel *)model;
@end
