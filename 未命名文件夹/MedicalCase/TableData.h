//
//  TableData.h
//  PullDownMenu
//
//  Created by lsw on 14-4-15.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableData : NSObject <NSCopying>

@property (nonatomic,assign)int index;//索引值，区分是检验还是检查的数据，1表示检验，2表示检查
@property (nonatomic, strong) NSString *sectionTitle;     //显示section title内容
@property (nonatomic, assign) NSInteger rowsOfSection;    //section中有多少行
@property (nonatomic, strong) NSMutableArray *cellsArray; //每一行显示的内容，暂时存string

+ (id)tableDataWithSectionTitle:(NSString *)sectionTitle rowsOfSection:(NSInteger)rowsOfSection cellsArray:(NSMutableArray *)cellsArray;      //实例化TableData数据

@end
