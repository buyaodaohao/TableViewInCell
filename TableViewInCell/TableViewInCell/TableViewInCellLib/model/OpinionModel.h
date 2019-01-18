//
//  OpinionModel.h
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpinionModel : NSObject
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *itemsContent;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *userIcon;
+(OpinionModel *)createOpinionModelFromDic:(NSDictionary *)modelDic;
@end
