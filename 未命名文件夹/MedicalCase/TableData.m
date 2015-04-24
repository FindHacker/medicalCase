//
//  TableData.m
//  PullDownMenu
//
//  Created by lsw on 14-4-15.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import "TableData.h"

@implementation TableData

+ (id)tableDataWithSectionTitle:(NSString *)sectionTitle rowsOfSection:(NSInteger)rowsOfSection cellsArray:(NSMutableArray *)cellsArray
{
    TableData *tableData = [[TableData alloc] init];
    tableData.sectionTitle = sectionTitle;
    tableData.rowsOfSection = rowsOfSection;
    tableData.cellsArray = cellsArray;
    return tableData;
}

- (id)copyWithZone:(NSZone *)zone
{
    TableData *copy = [[TableData allocWithZone:zone] init];
    copy.sectionTitle = self.sectionTitle;
    copy.rowsOfSection = self.rowsOfSection;
    copy.cellsArray = self.cellsArray;
    return copy;
}

@end
