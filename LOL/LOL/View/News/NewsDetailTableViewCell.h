//
//  NewsDetailTableViewCell.h
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsDetailModel;
@interface NewsDetailTableViewCell : UITableViewCell

//刷新数据
- (void)updateCellWithModel:(NewsDetailModel *)model;

@end
