//
//  RootNavigationController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
}

- (void)initNavigation
{
    //设置导航栏title颜色(设置)
    NSDictionary * textA = @{
                             NSFontAttributeName:[UIFont systemFontOfSize:18],
                             NSForegroundColorAttributeName:[UIColor whiteColor]
                             };
    [[UINavigationBar appearance] setTitleTextAttributes:textA];
    
    //设置导航栏背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:27/255.0 blue:38/255.0 alpha:1]];
    
    //设置状态栏字体颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //将info.plist中添加一项 Viewcontroller-based status bar appearance 属性设为 NO
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
