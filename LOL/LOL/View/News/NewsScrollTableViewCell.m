//
//  ScrollTableViewCell.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsScrollTableViewCell.h"
#import "LPCConfig.h"
#import "NewsAdvModel.h"
#import "NSString+URLEncoding.h"
#import "UIKit+AFNetworking.h"
#import "Masonry.h"

//扩展
@interface NewsScrollTableViewCell ()<
UIScrollViewDelegate>

@end

@implementation NewsScrollTableViewCell
{
    UIScrollView * _scrollView;
    UIView * _view;
    UILabel * _label;
    NSMutableArray * _arrayTitles;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    //消除选中效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //父视图
    UIView * superView = self.contentView;
    //1
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    //2
    [superView addSubview:_scrollView];
    
    //3 加在父视图上之后 才能自动布局
    //注意要先建立父子视图关系才能加约束
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       //约束条件
        make.left.equalTo(superView.mas_left).offset(0);
        make.top.equalTo(superView.mas_top).offset(0);
        make.width.equalTo(superView);
        make.height.equalTo(superView);
    }];
    
    //半透明的view
    _view = [[UIView alloc] init];
    _view.backgroundColor = [UIColor whiteColor];
    _view.alpha = 0.5;
    [superView addSubview:_view];
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        //约束条件
        make.left.equalTo(superView.mas_left).offset(0);
        make.bottom.equalTo(superView.mas_bottom).offset(0);
        make.width.equalTo(superView);
        make.height.equalTo(@20);
    }];
    
    //小标题
    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:13];
    _label.textColor = [UIColor blackColor];
    _label.text = @"内容介绍";
    [_view addSubview:_label];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        //约束条件
        make.left.equalTo(_view.mas_left).offset(5);
        make.bottom.equalTo(_view.mas_bottom).offset(0);
        //宽度取superView一半
        make.width.equalTo(superView).multipliedBy(1.0/2.0);
        make.height.equalTo(@20);
    }];
}

//刷新cell方法
- (void)updateCellWithArrayModel:(NSArray *)arrayModel
{
    _scrollView.contentSize = CGSizeMake(arrayModel.count * SCREEN_WIDTH, 0);
    if (arrayModel) {
        _arrayTitles = [[NSMutableArray alloc] init];
        
        UIImageView * lastIV = nil;
        
        for (int i = 0; i < arrayModel.count; i++) {
            //取出模型
            NewsAdvModel * model = arrayModel[i];
            //往小标题数组里面添加数据
            [_arrayTitles addObject:model.name];
            
            UIImageView * imageView = [[UIImageView alloc] init];
            [_scrollView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                //约束条件
                make.top.equalTo(_scrollView.mas_top).offset(0);
                //让图片视图一个贴一个
                make.left.equalTo(lastIV ? lastIV.mas_right : @0);
                make.width.equalTo(_scrollView);
                make.height.equalTo(_scrollView);
            }];
            
            lastIV = imageView;
            
            //设置图片
            NSURL * url = [NSURL URLWithString:[model.ban_img URLDecodedString]];
            [imageView setImageWithURL:url];
            
            
            _label.text = _arrayTitles[0];
        }
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.contentView.frame.size.width;
    _label.text = _arrayTitles[page];
}



@end
