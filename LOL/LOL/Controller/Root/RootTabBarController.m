//
//  RootTabBarController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "RootTabBarController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SettingViewController.h"
#import "InfosViewController.h"
#import "HerosViewController.h"
#import "NewsViewController.h"
#import "RootNavigationController.h"
#import "RDVTabBarItem.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setViewControllers];
}

- (void)setViewControllers
{
    //1.news
    NewsViewController * newsVC = [[NewsViewController alloc] init];
    RootNavigationController * newsNav = [[RootNavigationController alloc] initWithRootViewController:newsVC];
    
    //2.heros
    HerosViewController * herosVC = [[HerosViewController alloc] init];
    RootNavigationController * herosNav = [[RootNavigationController alloc] initWithRootViewController:herosVC];
    
    //3.infos
    InfosViewController * infosVC = [[InfosViewController alloc] init];
    RootNavigationController * infosNav = [[RootNavigationController alloc] initWithRootViewController:infosVC];
    
    //4.setting
    SettingViewController * settingVC = [[SettingViewController alloc] init];
    RootNavigationController * settingNav = [[RootNavigationController alloc] initWithRootViewController:settingVC];
    
    //将子视图添加到tabBar中
    self.viewControllers = @[newsNav,herosNav,infosNav,settingNav];
    
    //设置TabBar上面的信息
    [self customTabBar];
}

- (void)customTabBar
{
    //tabBar图片
    NSArray * tabBarItemImages = @[@"tab_icon_news",@"tab_icon_friend",@"tab_icon_quiz",@"tab_icon_more"];
    
    //tabBar标题
    NSArray * titleArray = @[@"新闻",@"英雄",@"资料",@"设置"];
    
    //让字体和图标颜色一起变
    NSDictionary * textAttributes_normal = nil;
    NSDictionary * textAttributes_selected = nil;
    
    //如果当前版本大于iOS6.1以上才能使用的方法
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        textAttributes_normal = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:9],
                                  NSForegroundColorAttributeName:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1]
                                  };
        textAttributes_selected = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:9],
                                    NSForegroundColorAttributeName:[UIColor colorWithRed:51/255.0 green:113/255.0 blue:183/255.0 alpha:1]
                                    };
    }
    
    NSInteger index = 0;
    
    for (RDVTabBarItem * item in self.tabBar.items) {
        item.unselectedTitleAttributes = textAttributes_normal;
        item.selectedTitleAttributes = textAttributes_selected;
        
        UIImage * selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",[tabBarItemImages objectAtIndex:index]]];
        
        UIImage * unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        item.title = titleArray[index];
        
        index++;
    }
    
}

//启动应用的时候播放音效
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self playDefaultAudio];
}

- (void)playDefaultAudio
{
    // <1> 获取音效路径
    NSString * path = [[NSBundle mainBundle] pathForResource:@"garen.mp3" ofType:nil];
    // <2> 将字符串路径转化为NSURL
    NSURL * url = [NSURL fileURLWithPath:path];
    // <3> 注册系统音频ID
    SystemSoundID ID;
    // <4> 创建系统音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &ID);
    // <5> 播放音效
    AudioServicesPlaySystemSound(ID);
}



@end
