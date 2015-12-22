//
//  NewsAdvModel.m
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsAdvModel.h"

@implementation NewsAdvModel

+ (NewsAdvModel *)newsAdvModelWithDict:(NSDictionary *)dict
{
    NewsAdvModel * model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
