//
//  NewsDetailTableViewCell.m
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import "NewsDetailTableViewCell.h"
#import "LPCConfig.h"
#import "NewsDetailModel.h"
#import "UIKit+AFNetworking.h"

@implementation NewsDetailTableViewCell
{
    UIImageView * _imageView;
    UILabel * _label_title;
    UILabel * _label_detail;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    //消除选中效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat cellHeight = 80; //约定好的cell高度
    CGFloat cellWidth = SCREEN_WIDTH;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, (cellHeight - 5*2)*1.2, cellHeight - 5*2)];
    [self.contentView addSubview:_imageView];
    
    _label_title = [[UILabel alloc] initWithFrame:CGRectMake(10 + _imageView.frame.size.width + 10, 6, cellWidth - (10 + _imageView.frame.size.width + 10) - 5, 35)];
    _label_title.numberOfLines = 0;
    _label_title.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_label_title];
    
    _label_detail = [[UILabel alloc] initWithFrame:CGRectMake(_label_title.frame.origin.x, 5 + _label_title.frame.size.height + 5, _label_title.frame.size.width, 20)];
    _label_detail.font = [UIFont systemFontOfSize:11];
    _label_detail.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [self.contentView addSubview:_label_detail];
}

//刷新数据
- (void)updateCellWithModel:(NewsDetailModel *)model
{
    [_imageView setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"default_hero_head"]];
    _label_title.text = model.title;
    _label_detail.text = model.newsDetail_short;
}


@end
