//
//  InfosViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "InfosViewController.h"
#import "LPCConfig.h"
#import "InfosYYYViewController.h"
#import "InfosMyCardViewController.h"
#import "ZBarSDK.h"
#import "UMSocial.h"
#import "MobClick.h"

@interface InfosViewController ()<
UITableViewDelegate,
UITableViewDataSource,
ZBarReaderDelegate,
UMSocialUIDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSArray * arrayItems;

@end

@implementation InfosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    //在初始化的时候定义了所有内容
    _arrayItems = @[
                    @[              //分组1
                        [InfosListItem itemWithTitle:@"物品资料" icon:@"more_icon_query" type:Infos_WPZL],
                        [InfosListItem itemWithTitle:@"对战助手" icon:@"first_win_calendar_win" type:Infos_DZZS]
                        ],
                    @[              //分组2
                        [InfosListItem itemWithTitle:@"官方网站" icon:@"more_icon_forum" type:Infos_GFWZ],
                        [InfosListItem itemWithTitle:@"兴趣部落" icon:@"icon_push_big" type:Infos_XQBL],
                        [InfosListItem itemWithTitle:@"摇一摇" icon:@"icon_push_big" type:Infos_YYY],
                        [InfosListItem itemWithTitle:@"我的二维码" icon:@"icon_push_big" type:Infos_MYCARD],
                        [InfosListItem itemWithTitle:@"扫一扫" icon:@"icon_push_big" type:Infos_SYS]
                        ],
                    @[              //分组3
                        [InfosListItem itemWithTitle:@"掌盟二维码" icon:@"chat_mobile_online" type:Infos_ZMEWM],
                        [InfosListItem itemWithTitle:@"知识学院" icon:@"more_icon_guess" type:Infos_ZSXY],
                        [InfosListItem itemWithTitle:@"英雄时刻" icon:@"ability_lol_hero_time" type:Infos_YXSK]
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
    
    InfosListItem * item = _arrayItems[indexPath.section][indexPath.row];
    
    cell.textLabel.text = item.title;
    cell.imageView.image = [UIImage imageNamed:item.iconName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    InfosListItem * item = _arrayItems[indexPath.section][indexPath.row];
    
    switch (item.type) {
        case Infos_YYY:
        {
            [MobClick event:@"YYY"];
            [self pushToDetail:item.type];
            break;
        }
        case Infos_MYCARD:
        {
            [self pushToDetail:item.type];
            break;
        }
        case Infos_SYS:
        {
            [self sysbutbuttonclick];
            break;
        }
        case Infos_DZZS:
        {
            [self cancelLocationPush];
            break;
        }
        default:
            break;
    }
}

- (void)pushToDetail:(Infos_FOUNDATION)type
{
    switch (type) {
        case Infos_YYY:
        {
            InfosYYYViewController * vc = [[InfosYYYViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case Infos_MYCARD:
        {
            InfosMyCardViewController * vc = [[InfosMyCardViewController alloc] init];
            vc.strCard = @"李沛池是God";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

//二维码
-(void)sysbutbuttonclick
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new]; reader.readerDelegate = self;
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE
                       to: 0];
    //    [self presentModalViewController: reader animated: YES];
    [self presentViewController:reader animated:YES completion:nil];
}

//二维码回调方法
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    NSLog(@"info=%@",info);
    // 得到条形码结果
    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    NSString * strOpenURL;
#if 0
    strOpenURL = @"http://www.baidu.com";
#elif 0
    strOpenURL = @"telprompt://110";
#elif 0
    strOpenURL = @"mailto://godlikelpc@126.com";
#elif 1
    strOpenURL = @"https://itunes.apple.com/cn/app/guan-men-fang-lu-bu-hua-fei/id1048349241?mt=8";
#else
    strOpenURL = @"prefs:root=Photos";
#endif
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strOpenURL]];
    
    // 将获得到条形码显示到我们的界面上
    // resultText.text = symbol.data;
    NSLog(@"%@",symbol.data);
    // 扫描时的图片显示到我们的界面上
    //  resultImage.image =
    // [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // 扫描界面退出
    //[reader dismissModalViewControllerAnimated: YES];
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

//分享
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


@implementation InfosListItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(Infos_FOUNDATION)type
{
    InfosListItem * item = [[InfosListItem alloc] init];
    item.title = title;
    item.iconName = iconName;
    item.type = type;
    return item;
}

@end





