//
//  CommenModel.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "CommenModel.h"

@implementation CommenModel
+(CommenModel *)createCommenModelWithModelDic:(NSDictionary *)modelDic
{
    CommenModel *model = [[CommenModel alloc]init];
    model.name = modelDic[@"name"];
    model.itemsContent = modelDic[@"itemsContent"];
    model.itemsContent = [model.itemsContent stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.content = modelDic[@"content"];
    model.content = [model.content stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.documents = (NSArray *)modelDic[@"documents"];    
    model.userIcon = modelDic[@"userIcon"];
    model.type = modelDic[@"type"];
    model.ID = modelDic[@"id"];
    model.time = modelDic[@"time"];
    model.countComment = [((NSNumber *)modelDic[@"countComment"]) intValue];
    model.comment = (NSDictionary *)modelDic[@"comment"];
    return model;
}
@end
