//
//  AnotherMainContentCell.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2019/11/28.
//  Copyright © 2019 云联智慧. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommenModel;
@protocol  AnotherMainContentCellDelegate <NSObject>

-(void)reloadCellHeightForModel:(CommenModel *)model tableViewHeight :(CGFloat)tableViewH atIndexPath:(NSIndexPath *)indexPath;

@end
@interface AnotherMainContentCell : UITableViewCell
@property(nonatomic,strong)CommenModel *contentModel;
@property(nonatomic,weak)id<AnotherMainContentCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;
/**获取cell高度*/
+(CGFloat)getCommenListCellHeightFromModel:(CommenModel *)model;
@end
