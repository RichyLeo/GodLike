//
//  NewsTitlesBaseViewController.h
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "RootViewController.h"

@interface NewsTitlesBaseViewController : RootViewController

//用于区别不同页面的请求
@property (nonatomic, assign) RequestType type;

@end
