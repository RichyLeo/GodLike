//
//  NewsViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBarController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title 代表改两个位置 nav tabBar
    self.navigationItem.title = @"新闻";
//    self.navigationController.navigationItem.title
    self.navigationController.navigationBarHidden = YES;
    
    [self initSCNav];
}

- (void)initSCNav
{
    NSArray * arrayControllers = @[@"NewsTitlesNewestViewController",@"NewsTitlesFunViewController",@"NewsTitlesGameViewController",@"NewsTitlesGirlsViewController",@"NewsTitlesOfficialViewController",@"NewsTitlesS5ViewController",@"NewsTitlesStratrgyViewController",@"NewsTitlesVideoViewController"];
    
    NSArray * arrayTitles = @[@"最新",@"娱乐",@"赛事",@"美女",@"官方",@"活动",@"攻略",@"视频"];
    
    NSMutableArray * arrayFinial = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arrayControllers.count; i++) {
        Class cls = NSClassFromString(arrayControllers[i]);
        UIViewController * vc = [[cls alloc] init];
        vc.title = arrayTitles[i];
        [arrayFinial addObject:vc];
    }
    
    SCNavTabBarController * scNTBC = [[SCNavTabBarController alloc] init];
    
    scNTBC.subViewControllers = arrayFinial;
    
    //设置滚动条的背景颜色
    [scNTBC setNavTabBarColor:[UIColor colorWithRed:35/255.0 green:43/255.0 blue:60/255.0 alpha:0.5]];
    
    //让底色和滚动条的背景色调一致
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:63/255.0 blue:80/255.0 alpha:1];
    
    //滑动条颜色
    [scNTBC setNavTabBarLineColor:[UIColor redColor]];
    
    //让sc展现出来
    [scNTBC addParentController:self];
}










@end
