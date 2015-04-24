//
//  PullMenuTable.h
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuTableCell.h"
#import "SectionButton.h"
#import "TableData.h"
#import "PullCellData.h"

@protocol PullMenuTableDelegate;
@protocol PullMenuTableClickSectionDelegate;

@interface PullMenuTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<PullMenuTableDelegate> pullDelegate;
@property (nonatomic, assign) id<PullMenuTableClickSectionDelegate> clickSectionDelegate;
@property (nonatomic, assign) CGFloat rowHeight;         //设置row高度，默认44.0f
@property (nonatomic, assign) CGFloat sectionHeight;     //设置section高度,默认50.0f
@property (nonatomic, assign) BOOL manyMenu;             //设置是否允许显示多个菜单，默认YES(允许多个菜单)
@property (nonatomic, assign) BOOL rowSectionText;       //设置选中row与section文本是否一样，默认NO（不一样）
@property (nonatomic, assign) BOOL manyChoice;           //是否允许多选(默认为NO，单选)
@property (nonatomic, assign) BOOL acrossGroupChoice;    //是否能够跨组多选(默认为NO，不能跨组多选)
@property (nonatomic, assign) BOOL groupManyCoice;       //group里面是否为多选(默认为NO，不能多选)

@property (nonatomic, strong) UITableView *pullTableView;   //用于显示的tableView

@property (nonatomic, strong) NSMutableArray *indexArray;   //选中index

@property (nonatomic, strong) NSMutableArray *imageArray;  //左部导航左边的图片，存UIImage

@property (nonatomic, strong) NSArray *pullMenuArr;  //数据源（二维数组）

- (void)selectAllSection;

- (BOOL)allSectionExpand;//所有的section都处于展开状态

@end

@protocol PullMenuTableDelegate <NSObject>
@optional
- (void)pullMenuTable:(PullMenuTable *)_pullTable indexPath:(NSIndexPath *)indexPath;

@end

@protocol PullMenuTableClickSectionDelegate <NSObject>
@optional
- (void)clickSection:(PullMenuTable *)_pullTable isOpen:(BOOL)isOpen section:(NSInteger)section;

@end