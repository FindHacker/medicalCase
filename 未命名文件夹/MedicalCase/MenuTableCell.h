//
//  MenuTableCell.h
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeparateView.h"
#import "PullCellData.h"

@interface MenuTableCell : UITableViewCell
#define FontSize [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]
#define TextColor [UIColor colorWithRed:51.0f / 255.0f green:50.0f / 255.0f blue:29.0f / 255.0f alpha:1.0f]

@property (nonatomic, strong) PullCellData *cellData;

- (void)changeCellContent;

@end
