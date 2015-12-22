//
//  LPCDataRequest.h
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    Enum_NewestPage = 207,
    Enum_GirlPage = 210,
    Enum_OfficalPage = 211,
    Enum_VideoPage = 212,
    Enum_FunPage = 213,
    Enum_StrategyPage = 214,
    Enum_S5Page = 215,
    Enum_GamePage = 216
}RequestType;

//这个类 主要负责请求数据 并把下载到得数据解析成我们可以直接用的
@interface LPCDataRequest : NSObject


/*
 请求新闻数据
 */
+ (NSURLSessionDataTask *)getRequestType:(RequestType)type currentPage:(int)page finishData:(void (^)(id obj,NSError * error))block;



@end
