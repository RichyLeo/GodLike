//
//  NewsAdvModel.h
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsAdvModel : NSObject

//广告ID
@property (nonatomic, copy) NSString * article_id;

//计数
@property (nonatomic, copy) NSString * comment_count;

//广告图片url
@property (nonatomic, copy) NSString * ban_img;

//广告标题
@property (nonatomic, copy) NSString * name;

+ (NewsAdvModel *)newsAdvModelWithDict:(NSDictionary *)dict;

@end
