//
//  OpinionModel.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "OpinionModel.h"

@implementation OpinionModel
+(OpinionModel *)createOpinionModelFromDic:(NSDictionary *)modelDic
{
    OpinionModel *model = [[OpinionModel alloc]init];
    model.time = modelDic[@"time"];
    model.itemsContent = modelDic[@"itemsContent"];
    //处理汉字编码
    model.itemsContent = [model.itemsContent stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    model.name = modelDic[@"name"];
    model.userIcon = modelDic[@"userIcon"];
    return model;
}
@end
