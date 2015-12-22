//
//  InfosMyCardViewController.m
//  LOL
//
//  Created by 李沛池 on 15/11/24.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "InfosMyCardViewController.h"
#import "QRCodeGenerator.h"

@interface InfosMyCardViewController ()

@end

@implementation InfosMyCardViewController
{
    UIImageView * _iView;
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
    _iView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _iView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    [self.view addSubview:_iView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"save" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, _iView.frame.origin.y + _iView.frame.size.height + 20, 50, 30);
    button.center = CGPointMake(_iView.center.x, button.center.y);
    [button addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)updateData
{
    //根据字符串和图片大小生成二维码
    UIImage * image = [QRCodeGenerator qrImageForString:_strCard imageSize:200];
    _iView.image = image;
}

- (void)saveImage
{
    //写到相册
    UIImageWriteToSavedPhotosAlbum(_iView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

//指定的回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString * message = nil;
    if (error != NULL) {
        message = @"保存图片失败";
    }else {
        message = @"保存图片成功";
    }
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:message delegate:nil cancelButtonTitle:@"1" otherButtonTitles:@"2", nil];
    [alert show];
}

@end
