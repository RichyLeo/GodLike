//
//  NewsDetailModel.m
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

//为与关键字重复的成员变量赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _newsDetail_id = value;
    }
    if ([key isEqualToString:@"short"]) {
        _newsDetail_short = value;
    }
}

//防止外界访问不存在的属性时崩溃
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil; //属性不存在时返回nil
}

+ (NewsDetailModel *)newsDetailModelWithDict:(NSDictionary *)dict
{
    NewsDetailModel * model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}


@end
