//
//  NewsDetailViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/20.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "RDVTabBarController.h"
#import "ApiURL.h"
#import "LPCConfig.h"
#import "MBProgressHUD.h"

@interface NewsDetailViewController ()<
UIWebViewDelegate,
UIScrollViewDelegate>

//需要setter 和 getter方法
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation NewsDetailViewController
{
    //存放下载操作的队列
    NSOperationQueue * queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
    [self updateData];
}

- (void)initData
{
    
}

- (void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATES_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATES_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

- (void)updateData
{
    //异步下载网页信息
    __weak typeof(self) weakSelf = self;
    /*
     block对于其变量,都会形成strong reference , 对于self就会形成强引用,
     
     而如果self本身对block也是强引用, 就会造成strong reference循环
     造成内存泄露, 为了防止这样一个现象发生,在block外就应该创建一个
     weak(__block) reference
     */
    
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
       
        NSString * strURL = [NSString stringWithFormat:kNewsDetailUrlString,self.newsID];
        
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:strURL]];
        
        //回到主线程刷新webView
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.webView loadRequest:request];
            
            [MBProgressHUD showHUDAddedTo:_webView animated:YES];
        }];
    }];
    
    queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO; //显示导航栏
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成
    
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败
    
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}



@end
