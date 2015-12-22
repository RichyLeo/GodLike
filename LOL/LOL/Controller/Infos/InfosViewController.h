//
//  InfosViewController.h
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "RootViewController.h"

/**
 *  功能枚举 用来区分每个功能
 **/
typedef enum {
    Infos_WPZL = 1,
    Infos_DZZS,
    Infos_GFWZ,
    Infos_XQBL,
    Infos_ZMEWM,
    Infos_ZSXY,
    Infos_YXSK,
    Infos_YYY,
    Infos_MYCARD,
    Infos_SYS
}Infos_FOUNDATION;

@interface InfosViewController : RootViewController

@end


@interface InfosListItem : NSObject

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * iconName;

@property (nonatomic, assign) Infos_FOUNDATION type;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)iconName type:(Infos_FOUNDATION)type;

@end


