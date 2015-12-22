//
//  NewsTitlesVideoViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsTitlesVideoViewController.h"

@interface NewsTitlesVideoViewController ()

@end

@implementation NewsTitlesVideoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        super.type = Enum_VideoPage;
    }
    return self;
}

//汗水决定成败    智商决定效率

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

