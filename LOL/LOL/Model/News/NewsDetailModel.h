//
//  NewsDetailModel.h
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject

//详细内容ID
@property (nonatomic, copy) NSString * newsDetail_id;

//cell大标题
@property (nonatomic, copy) NSString * title;

//位置计数属性
@property (nonatomic, copy) NSString * comment_count;

//来源
@property (nonatomic, copy) NSString * source;

//cell图标url地址
@property (nonatomic, copy) NSString * icon;

//新闻内容简介
@property (nonatomic, copy) NSString * newsDetail_short;

+ (NewsDetailModel *)newsDetailModelWithDict:(NSDictionary *)dict;


@end
