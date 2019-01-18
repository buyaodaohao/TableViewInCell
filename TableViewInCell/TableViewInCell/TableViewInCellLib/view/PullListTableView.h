//
//  PullListTableView.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PullListTableDelegate;
@interface PullListTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,weak)id<PullListTableDelegate> pullListDelegate;
@property (nonatomic,assign) long count;
@property (nonatomic,assign) long limit;
@property(nonatomic,strong)UIColor *headerColor;
@property(nonatomic,strong)UIColor *footerColor;
- (void)setupRefresh;
/**置空footer,去掉上拉刷新*/
-(void)setFooterNil;
-(void)endHeaderFresh;
-(void)endFooterFresh;
@end

@protocol PullListTableDelegate <NSObject>
@required
-(void)getHeaderRereshing:(PullListTableView *)tableview;
-(void)getHeaderRereshed:(PullListTableView *)tableview;
@optional
-(void)getFooterRereshing:(PullListTableView *)tableview;
-(void)getFooterRereshed:(PullListTableView *)tableview;
@end
