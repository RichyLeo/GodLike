//
//  AppDelegate.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "UMessage.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "MobClick.h"

#define KEY_BAIDUMAP @"v9mGII0YmpjQGyqrHXT2uhcv"
#define KEY_UMMESSAGE @"565ec27b67e58e7c27000a0d"
#define KEY_QQ @"8UGdR7OSl7pI0K2G"
#define ID_QQ @"1104926281"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //如果X-code7 跑ios9模拟器 要第一个设置rootVC
    //加载根视图
    [self initRootViewController];
    
    //友盟统计
    [self UMCount];
    
    //友盟分享
    [self UMShare];
    
    //友盟推送
    [self UMMessage:launchOptions];
    
    //百度地图
    [self baiduMap];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

#pragma mark - RootVC
//加载根视图
- (void)initRootViewController
{
    RootTabBarController * rootTBC = [[RootTabBarController alloc] init];
    self.window.rootViewController = rootTBC;
}

//友盟统计
- (void)UMCount
{
    [MobClick startWithAppkey:KEY_UMMESSAGE reportPolicy:BATCH   channelId:@"Web"];
    
    [MobClick profileSignInWithPUID:@"Godlike"];
}

//友盟分享
- (void)UMShare
{
    [UMSocialData setAppKey:KEY_UMMESSAGE];
    
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:ID_QQ appKey:KEY_QQ url:@"http://www.umeng.com/social"];
}

//友盟推送
- (void)UMMessage:(NSDictionary *)launchOptions
{
    //set AppKey and AppSecret
    [UMessage startWithAppkey:KEY_UMMESSAGE launchOptions:launchOptions];
    
    //ios大于等于8.1
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_1
    if(__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_1)
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
}

//百度地图
- (void)baiduMap
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:KEY_BAIDUMAP generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}



@end
