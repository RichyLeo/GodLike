//
//  SettingViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "SettingViewController.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "SettingBaiduMapViewController.h"

@interface SettingViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UMSocialUIDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * arrayItems;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}

- (void)initData
{
    //在初始化的时候定义了所有内容
    _arrayItems = @[
                    @[              //分组1
                        [SettingListItem itemWithTitle:@"分享" icon:@"first_win_calendar_win" type:Setting_Share],
                        [SettingListItem itemWithTitle:@"第三方登陆" icon:@"first_win_calendar_win" type:Setting_LOGINQQ]
                        ],
                    @[              //分组2
                        [SettingListItem itemWithTitle:@"定时炸弹" icon:@"first_win_calendar_win" type:Setting_LOCATIONPUSH],
                        ],
                    @[              //分组3
                        [SettingListItem itemWithTitle:@"百度地图" icon:@"first_win_calendar_win" type:Setting_BAIDUMAP]
                        ]
                    ];
}

- (void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)_arrayItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    SettingListItem * item = _arrayItems[indexPath.section][indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.iconName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SettingListItem * item = _arrayItems[indexPath.section][indexPath.row];
    
    switch (item.type) {
        case Setting_BAIDUMAP:
        {
            [self pushToDetail:item.type];
            break;
        }
        case Setting_LOCATIONPUSH:
        {
            [self locationPush];
            break;
        }
        case Setting_Share:
        {
            [self share];
            break;
        }
        case Setting_LOGINQQ:
        {
            [self loginQQ];
            break;
        }
        default:
            break;
    }
}

- (void)pushToDetail:(Setting_FOUNDATION)type
{
    switch (type) {
        case Setting_BAIDUMAP:
        {
            SettingBaiduMapViewController * vc = [[SettingBaiduMapViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

//本地推送
- (void)locationPush
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:3];//10秒后通知
        notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=13; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"爆炸了";//提示信息 弹出提示框
        notification.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        
        // NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

//取消本地通知
- (void)cancelLocationPush
{
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArr = [app scheduledLocalNotifications];
    
    if (localArr) {
        for (UILocalNotification *noti in localArr) {
            
            [app cancelLocalNotification:noti];
            NSLog(@"拆除炸弹");
        }
    }
    
}

- (void)share
{
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"神Godlike"
                                     shareImage:[UIImage imageNamed:@"1111Icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:self];
}

//QQ授权登陆
- (void)loginQQ
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}



@end



@implementation SettingListItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(Setting_FOUNDATION)type
{
    SettingListItem * item = [[SettingListItem alloc] init];
    item.title = title;
    item.iconName = iconName;
    item.type = type;
    return item;
}

@end


