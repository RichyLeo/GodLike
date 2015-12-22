//
//  LPCDataRequest.m
//  LOL
//
//  Created by 李沛池 on 15/11/18.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "LPCDataRequest.h"
#import "AFHTTPSessionManager.h"
#import "ApiURL.h"
#import "NewsAdvModel.h"
#import "NewsDetailModel.h"

static NSString * SERVER_URL = @"http://lol.data.shiwan.com";

@implementation LPCDataRequest

+ (id)sharedClient
{
    static AFHTTPSessionManager * sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:SERVER_URL]];
    });
    /*
     AFSecurityPolicy
     NSURLConnection已经封装了https连接的建立、数据加密解密的功能,我们可以直接访问https网站,但是并没有验证证书的合法性,无法避免中间人的攻击,要做到真正的安全通讯,需要我们手动验证服务器返回的证书,AFSecurityPolicy封装了证书验证的过程,让用户可以轻易使用,除了去系统信任CA机构列表验证,还支持SSLPinning方式的验证
     */
    sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
    sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml", nil];
    
    return sharedClient;
}

/*
 请求新闻数据
 */
+ (NSURLSessionDataTask *)getRequestType:(RequestType)type currentPage:(int)page finishData:(void (^)(id obj,NSError * error))block
{
    NSString * strURL = [NSString stringWithFormat:URL_News_Base,type,page];
    
    return [[LPCDataRequest sharedClient] GET:strURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (block) {
            block([self parseToModel:responseObject],nil);//回传数据
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"数据下载失败 - NewsPage");
        if (block) {
            block(nil,error);//失败了要传回去错误原因
        }
    }];
}

//解析
+ (NSArray *)parseToModel:(NSDictionary *)responseObject
{
    //处理广告页数据
    NSArray * arrayRecomm = responseObject[@"recomm"];//获取新闻页广告信息
    
    //创建可变数组 储存数据模型
    NSMutableArray * arrayNewsAdv = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in arrayRecomm) {
        NewsAdvModel * model = [NewsAdvModel newsAdvModelWithDict:dict];
        [arrayNewsAdv addObject:model];
    }
    
    //处理详细页信息
    NSArray * arrayResult = responseObject[@"result"];
    
    NSMutableArray * arrayResultModel = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in arrayResult) {
        NewsDetailModel * model = [NewsDetailModel newsDetailModelWithDict:dict];
        [arrayResultModel addObject:model];
    }
    
    return @[arrayNewsAdv,arrayResultModel];
}

@end
