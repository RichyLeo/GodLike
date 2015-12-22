//
//  SettingBaiduMapViewController.m
//  LOL
//
//  Created by 李沛池 on 15/12/16.
//  Copyright © 2015年 LPC. All rights reserved.
//

#import "SettingBaiduMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface SettingBaiduMapViewController ()<
BMKMapViewDelegate>

@end

@implementation SettingBaiduMapViewController
{
    BMKMapView* _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载百度地图 1
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.view = _mapView;
    
    //打开实时路况图层
    [_mapView setTrafficEnabled:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void) viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 59.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是俄罗斯";
    [_mapView addAnnotation:annotation];
}

// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

@end
