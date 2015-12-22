//
//  SettingViewController.h
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "RootViewController.h"

typedef enum {
    Setting_BAIDUMAP = 1,
    Setting_LOCATIONPUSH,
    Setting_Share,
    Setting_LOGINQQ
}Setting_FOUNDATION;

@interface SettingViewController : RootViewController

@end




@interface SettingListItem : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * iconName;

@property (nonatomic, assign) Setting_FOUNDATION type;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(Setting_FOUNDATION)type;

@end

