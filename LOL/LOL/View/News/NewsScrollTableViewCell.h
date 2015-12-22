//
//  ScrollTableViewCell.h
//  LOL
//
//  Created by 李沛池 on 15/11/17.
//  Copyright (c) 2015年 LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsScrollTableViewCell : UITableViewCell

//刷新cell方法
- (void)updateCellWithArrayModel:(NSArray *)arrayModel;

@end
