//
//  InfosYYYViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/24.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "InfosYYYViewController.h"

@interface InfosYYYViewController ()

@end

@implementation InfosYYYViewController
{
    UIImageView * _iViewBird;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor cyanColor];
    
    //主显示视图
    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    //加载背景图片
    UIImageView * iViewBG = [[UIImageView alloc] initWithFrame:view.frame];
    iViewBG.image = [UIImage imageNamed:@"back2.jpg"];
    [view addSubview:iViewBG];
    
    //创建鸟的动画视图
    _iViewBird = [[UIImageView alloc] initWithFrame:CGRectMake(110, 150, 60, 48)];
    _iViewBird.image = [UIImage imageNamed:@"DOVE 1"];
    [view addSubview:_iViewBird];
    
    NSMutableArray * arrayImage = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 19; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"DOVE %ld.png",i]];
        [arrayImage addObject:image];
    }
    //设置鸟的动画
    _iViewBird.animationImages = arrayImage;
    _iViewBird.animationDuration = 1;
    _iViewBird.animationRepeatCount = 0;
    
    //设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    //并让自己成为第一响应者
    [self becomeFirstResponder];
}


#pragma mark - 摇一摇

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动开始");
    
    [_iViewBird startAnimating];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动取消");
    
    [self performSelector:@selector(findGirl:) withObject:nil afterDelay:3.0f];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake) {
        NSLog(@"摇动结束");
        [self performSelector:@selector(findGirl:) withObject:event afterDelay:3.0f];
    }
}

- (void)findGirl:(UIEvent *)event
{
    [_iViewBird stopAnimating];
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"中奖了" message:@"好几亿" delegate:nil cancelButtonTitle:@"God" otherButtonTitles:@"Like", nil];
        [av show];
    }
}


@end
