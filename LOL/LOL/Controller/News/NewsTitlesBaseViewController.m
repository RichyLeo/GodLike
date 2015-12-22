//
//  NewsTitlesBaseViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsTitlesBaseViewController.h"
#import "NewsScrollTableViewCell.h"
#import "NewsDetailTableViewCell.h"
#import "MJRefresh.h"
#import "NewsDetailViewController.h"
#import "NewsDetailModel.h"
#import "RDVTabBarController.h"

@interface NewsTitlesBaseViewController ()<
UITableViewDelegate,
UITableViewDataSource>

@end

@implementation NewsTitlesBaseViewController
{
    UITableView * _tableView;
    
    NSMutableArray * _arrayDS_ad; //存放广告页数据
    NSMutableArray * _arrayDS_detail; //存放详细页数据
    BOOL _isLoadMore; //用于区别是加载更多还是刷新
    int _pageNum;     //当前页数
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
    [self updateData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;//界面显示时隐藏导航控制器
    //显示tabBar
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)initData
{
    _pageNum = 1;
    _isLoadMore = NO;
}

- (void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATES_BAR_HEIGHT - TABBAR_HEIGHT)];
    // SCREEN_HEIGHT - 44 - 20 - 49
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self addHeaderMJ];
    [self addFooterMJ];
}

- (void)addHeaderMJ
{
    //下拉刷新
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewestData)];
    _tableView.header = header;
}

- (void)addFooterMJ
{
    //上拉加载
    MJRefreshAutoGifFooter * footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //取得动画图片数组
    NSMutableArray * arrayImages = [self refreshingImages];
    
    [footer setImages:arrayImages forState:MJRefreshStateRefreshing];
    _tableView.footer = footer;
}

//初始化动画图片数组
- (NSMutableArray *)refreshingImages
{
    NSMutableArray * arrayImages = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 2; i++) {
//        [NSBundle mainBundle] pathForResource:<#(NSString *)#> ofType:<#(NSString *)#> 会避免内存加载图片过多导致卡顿问题
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"common_loading_anne_%ld",i]];
        [arrayImages addObject:image];
    }
    return arrayImages;
}

- (void)loadNewestData
{
    //下拉刷新本页数据
    _pageNum = 1;
    _isLoadMore = NO;
    [self updateData];
}

- (void)loadMoreData
{
    //上拉加载更多
    _pageNum++;
    _isLoadMore = YES;
    [self updateData];
}

- (void)updateData
{
    [LPCDataRequest getRequestType:_type currentPage:_pageNum finishData:^(id obj, NSError *error) {
        if (obj) {
            if (_isLoadMore) {
                //加载更多的时候需要追加数据
                [_arrayDS_detail addObjectsFromArray:[obj lastObject]];
                [_tableView.footer endRefreshing];
            }else {
                _arrayDS_ad = [obj firstObject];
                _arrayDS_detail = [obj lastObject];
                [_tableView.header endRefreshing];
            }
            
            [self updateUI];
        }else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)updateUI
{
    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_arrayDS_detail) {
        return 0;
    }
    return _arrayDS_detail.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * cellIDScroll = @"cellIDScroll";
        NewsScrollTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIDScroll];
        if (!cell) {
            cell = [[NewsScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDScroll];
        }
        
        //刷新cell 填充数据
        [cell updateCellWithArrayModel:_arrayDS_ad];
        
        return cell;
    }else {
        static NSString * cellIDNewsDetail = @"cellIDNewsDetail";
        NewsDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIDNewsDetail];
        if (!cell) {
            cell = [[NewsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIDNewsDetail];
        }
        
        //刷新cell 填充数据
        [cell updateCellWithModel:_arrayDS_detail[indexPath.row - 1]];
        
        return cell;
    }
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
    }else {
        return 80;
    }
}

#pragma mark - 跳转到详情

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //避免点到广告页崩溃
    if (indexPath.row == 0) {
        return;
    }
    
    //获取当前选中的cell对应的数据模型
    NewsDetailModel * model = _arrayDS_detail[indexPath.row - 1];
    //创建详情页
    NewsDetailViewController * newsDetailVC = [[NewsDetailViewController alloc] init];
    newsDetailVC.newsID = model.newsDetail_id;
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}






@end