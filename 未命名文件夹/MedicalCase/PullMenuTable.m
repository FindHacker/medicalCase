//
//  PullMenuTable.m
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import "PullMenuTable.h"

@interface PullMenuTable ()
{
    NSMutableArray *sectionArray;    //存储section
//    NSArray *beginDataSource;        //存储开始时的数据
    NSIndexPath *currentIndexPath;   //当前选中的indexPath
    
    NSMutableArray *dataSourceArr;
}

@end

@implementation PullMenuTable

@synthesize rowHeight;
@synthesize sectionHeight;
@synthesize manyMenu;
@synthesize rowSectionText;
@synthesize pullMenuArr;
@synthesize pullTableView;
@synthesize imageArray = _imageArray;

@synthesize indexArray;

@synthesize manyChoice;
@synthesize acrossGroupChoice;
@synthesize groupManyCoice;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews  = YES;
        CGRect rect = frame;
        rect.origin.x = 0.0f;
        rect.origin.y = 0.0f;
        
        pullTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        pullTableView.dataSource = self;
        pullTableView.delegate = self;
        [self addSubview:pullTableView];


        rowHeight = 44.0f;
        sectionHeight = 50.0f;
        manyMenu = YES;
        rowSectionText = NO;
        pullTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        pullTableView.showsVerticalScrollIndicator = NO;
        
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(2.0f, -2.0f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 2.0f;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Initialization code
        
        CGRect rect = self.frame;
        rect.origin.x = 0.0f;
        rect.origin.y = 0.0f;
        
        pullTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        pullTableView.dataSource = self;
        pullTableView.delegate = self;
        [self addSubview:pullTableView];
        
        rowHeight = 44.0f;
        sectionHeight = 50.0f;
        manyMenu = YES;
        rowSectionText = NO;
        pullTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        pullTableView.showsVerticalScrollIndicator = NO;
        
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(2.0f, -2.0f);
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowRadius = 2.0f;
    }
    return self;

}
//- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
//{
//    self = [super initWithFrame:frame style:style];
//    
//    if (self)
//    {
////        self.alpha = 0.9f;
//        
//        rowHeight = 44.0f;
//        sectionHeight = 50.0f;
//        manyMenu = YES;
//        rowSectionText = NO;
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
//        
////        self.clipsToBounds = NO;
//        self.layer.masksToBounds = NO;
//        
//        self.layer.shadowColor = [[UIColor blackColor] CGColor];
//        self.layer.shadowOffset = CGSizeMake(2.0f, 0.0f);
//        self.layer.shadowOpacity = 1.0f;
//        self.layer.shadowRadius = 2.0f;
//        
//        self.dataSource = self;
//        self.delegate = self;
//    }
//    
//    return self;
//}

- (void)setPullMenuArr:(NSArray *)_pullMenuArr
{
    sectionArray = [[NSMutableArray alloc] init];
    indexArray = [[NSMutableArray alloc] init];
    
    pullMenuArr = [[NSArray alloc] initWithArray:_pullMenuArr copyItems:YES];
    dataSourceArr = [NSMutableArray arrayWithArray:_pullMenuArr];
    
    for (NSInteger i = 0; i < [dataSourceArr count]; i++)
    {
        TableData *tableData = [dataSourceArr objectAtIndex:i];
        tableData.rowsOfSection = 0;
    }
    
    [self setExtraCellLineHidden:pullTableView];
    
    [pullTableView reloadData];
}

//- (void)setDataSourceArr:(NSMutableArray *)_dataSourceArr
//{
//    dataSourceArr = _dataSourceArr;
//    
//    sectionArray = [[NSMutableArray alloc] init];
//    beginDataSource = [[NSArray alloc] initWithArray:dataSourceArr copyItems:YES];
//    
//    for (NSInteger i = 0; i < [dataSourceArr count]; i++)
//    {
//        TableData *tableData = [dataSourceArr objectAtIndex:i];
//        tableData.rowsOfSection = 0;
//    }
//    
//    [self setExtraCellLineHidden:pullTableView];
//    
//    [pullTableView reloadData];
//}

#pragma mark - 隐藏多余的分割线
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (BOOL)allSectionExpand
{
    for(int i=0;i<[dataSourceArr count];i++)
    {
        NSInteger numberOfCells = [[pullMenuArr objectAtIndex:i] rowsOfSection];
        //        NSString *sectionTitle = [[beginDataSource objectAtIndex:secButton.tag] sectionTitle];
        
        [[dataSourceArr objectAtIndex:i] setRowsOfSection:numberOfCells];
        //        [[dataSourceArr objectAtIndex:secButton.tag] setSectionTitle:sectionTitle];
        
        [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    return YES;
}

#pragma mark - 点击section部分
- (void)clickSectionButton:(SectionButton *)secButton
{
    
//    if([self allSectionExpand])
//    {
//        return;
//    }
    
    secButton.open = !secButton.open;
    
    if (secButton.open == YES)
    {
        NSInteger numberOfCells = [[pullMenuArr objectAtIndex:secButton.tag] rowsOfSection];
//        NSString *sectionTitle = [[beginDataSource objectAtIndex:secButton.tag] sectionTitle];
        
        [[dataSourceArr objectAtIndex:secButton.tag] setRowsOfSection:numberOfCells];
//        [[dataSourceArr objectAtIndex:secButton.tag] setSectionTitle:sectionTitle];
        
        [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:secButton.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [UIView animateWithDuration:0.6 animations:^{
//            
//            [self reloadSections:[NSIndexSet indexSetWithIndex:secButton.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];

        [pullTableView selectRowAtIndexPath:currentIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
//        NSString *sectionTitle = [[beginDataSource objectAtIndex:secButton.tag] sectionTitle];

        [[dataSourceArr objectAtIndex:secButton.tag] setRowsOfSection:0];
//        [[dataSourceArr objectAtIndex:secButton.tag] setSectionTitle:sectionTitle];
        
        [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:secButton.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [UIView animateWithDuration:0.6 animations:^{
//            
//            [self reloadSections:[NSIndexSet indexSetWithIndex:secButton.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }];
    }
    
    if ([self.clickSectionDelegate respondsToSelector:@selector(clickSection:isOpen:section:)])
    {
        [self.clickSectionDelegate clickSection:self isOpen:secButton.open section:secButton.tag];
    }
    
    if (manyMenu == NO && secButton.open == YES)
    {
        [self closeOtherSectionMenu:secButton];
    }
}

#pragma mark - 关闭其他菜单
- (void)closeOtherSectionMenu:(SectionButton *)secButton
{
    for (SectionButton *sectionButton in sectionArray)
    {
        if ([sectionButton isEqual:secButton] == NO && sectionButton.open == YES)
        {
            sectionButton.open = NO;
            
            [[dataSourceArr objectAtIndex:sectionButton.tag] setRowsOfSection:0];
            [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:sectionButton.tag] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

#pragma mark - section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataSourceArr count];
}

#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndexPath = indexPath;
    
    if (manyChoice == YES)
    {
        if (acrossGroupChoice == YES)
        {
            if (groupManyCoice == YES)
            {
                if ([indexArray containsObject:indexPath] == YES)
                {
                    [indexArray removeObject:indexPath];
                }
                else
                {
                    [indexArray addObject:indexPath];
                }
            }
            else
            {
                for (NSInteger i = 0; i < [indexArray count]; i++)
                {
                    NSIndexPath *pathObject = [indexArray objectAtIndex:i];
                    if (pathObject.section == indexPath.section)
                    {
                        [indexArray removeObjectAtIndex:i];
                        i--;
                    }
                }
                
                [indexArray addObject:indexPath];
            }
        }
        else
        {
            if (groupManyCoice == YES)
            {
                for (NSInteger i = 0; i < [indexArray count]; i++)
                {
                    NSIndexPath *pathObject = [indexArray objectAtIndex:i];
                    if (pathObject.section != indexPath.section)
                    {
                        [indexArray removeObjectAtIndex:i];
                        i--;
                    }
                }
                
                if ([indexArray containsObject:indexPath] == NO)
                {
                    [indexArray addObject:indexPath];
                }
            }
            else
            {
                [indexArray removeAllObjects];
                [indexArray addObject:indexPath];
            }
        }
    }
    
    MenuTableCell *cell = (MenuTableCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (rowSectionText == YES)
    {
        [[dataSourceArr objectAtIndex:indexPath.section] setSectionTitle:cell.textLabel.text];

        [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];

        [pullTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    for (NSInteger i = 0; i < [dataSourceArr count]; i++)
    {
        if (i != indexPath.section)
        {
            if (manyChoice == NO)
            {
                NSString *sectionTitle = [[pullMenuArr objectAtIndex:i] sectionTitle];
                [[dataSourceArr objectAtIndex:i] setSectionTitle:sectionTitle];
                [pullTableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationNone];
            }
        }
    }
    
    if ([self.pullDelegate respondsToSelector:@selector(pullMenuTable:indexPath:)])
    {
        cell.cellData = [[[dataSourceArr objectAtIndex:indexPath.section] cellsArray] objectAtIndex:indexPath.row];
        [self.pullDelegate pullMenuTable:self indexPath:indexPath];
    }
}

- (void)selectAllSection
{
    if (rowSectionText == YES)
    {
        [[dataSourceArr objectAtIndex:1] setSectionTitle:@"全部"];
        [[dataSourceArr objectAtIndex:2] setSectionTitle:@"全部"];
        
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
        [indexSet addIndex:1];
        [indexSet addIndex:2];
        
        [pullTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - 重写section
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionButton *sectionButton;
    
    if (section < [sectionArray count])
    {
        sectionButton = [sectionArray objectAtIndex:section];
    }
    else
    {
        sectionButton = [[SectionButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, pullTableView.sectionHeaderHeight)];
    
        sectionButton.tag = section;
        if (section > 0)
        {
            if (section - 1 < [_imageArray count])
            {
                [sectionButton setLeftAndRightImageView:[_imageArray objectAtIndex:section - 1]];
            }
        }
        else
        {
            [sectionButton setLeftAndRightImageView:nil];
        }
        [sectionButton addTarget:self action:@selector(clickSectionButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [sectionArray addObject:sectionButton];
    }
    
    if (section < [dataSourceArr count])
    {
        [sectionButton setTitle:[[dataSourceArr objectAtIndex:section] sectionTitle] forState:UIControlStateNormal];
    }
    
    return sectionButton;
}

#pragma mark - 设置section高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}

#pragma mark - 设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

#pragma mark - 设置section中的row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataSourceArr objectAtIndex:section] rowsOfSection];
}

#pragma mark - 设置cell中的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[MenuTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.textLabel.highlightedTextColor = LeftNavigationColor;
        if (manyChoice == YES)
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    if (manyChoice == YES)
    {
        if ([indexArray containsObject:indexPath] == YES)
        {
            cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0f];
            cell.textLabel.textColor = LeftNavigationColor;
        }
        else
        {
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = LeftNavigationColor;
        }
    }
    
    cell.textLabel.text = [[[[dataSourceArr objectAtIndex:indexPath.section] cellsArray] objectAtIndex:indexPath.row] reportName];
//    [cell changeCellContent];
    
    return cell;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.frame;
    pullTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];

}
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, 0, 0);
//    CGContextAddLineToPoint(context, rect.size.width, 0);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
//    CGContextAddLineToPoint(context, 0, rect.size.height);
//    CGContextAddLineToPoint(context, 0, 0);
//    CGContextSetLineWidth(context, 0.5f);
//    
//    CGContextStrokePath(context);
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
