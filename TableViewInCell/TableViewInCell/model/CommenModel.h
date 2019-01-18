//
//  CommenModel.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommenModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *deptName;
@property(nonatomic,copy)NSString *itemsContent;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSArray *documents;
@property(nonatomic,copy)NSString *userIcon;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)int countComment;
@property (nonatomic,strong) NSDictionary *comment;
/**cell中tableView高度*/
@property(nonatomic,assign)float childTableViewHeight;
/**是否展示意见列表*/
@property(nonatomic,assign)BOOL showChildTableView;
@property(nonatomic,strong)NSMutableArray *opinionsArray;
+(CommenModel *)createCommenModelWithModelDic:(NSDictionary *)modelDic;
@end
