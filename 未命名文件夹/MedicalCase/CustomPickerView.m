//
//  CustomPickerView.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/17.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "CustomPickerView.h"



@interface CustomPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) UIPickerView *leftPickerView;
@property (nonatomic,strong) UIPickerView *rightPickerView;
@property (nonatomic,strong) UILabel *labelMiddle;
@property (nonatomic,strong) UINavigationBar *naviagtionBar;
@property (nonatomic,strong) UINavigationItem *navigationItem;

@property (nonatomic,strong) NSString *startAgeString;
@property (nonatomic,strong) NSString *endAgeString;

@end
#define maxAge 120

#define labelWidth 24
#define leftMargin  5
@implementation CustomPickerView

#pragma mask - property
-(NSMutableArray *)dataSourceTwo
{
    if (!_dataSourceTwo) {
        _dataSourceTwo = [[NSMutableArray alloc] init];
    }
    return _dataSourceTwo;
}
-(NSMutableArray *)dataSourceOne
{
    if (!_dataSourceOne) {
        _dataSourceOne = [[NSMutableArray alloc] init];
    }
    return _dataSourceOne;
}
#pragma mask - init frame
-(id)initWithCoder:(NSCoder *)aDecoder
{
   self =  [super initWithCoder:aDecoder];
   [self setInitView];
   return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setInitView];
    return self;
}
-(void)setInitView
{
    self.clipsToBounds = YES;

    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.leftPickerView = [self setUpPickerView];
    self.leftPickerView.tag = 1;
    
    self.rightPickerView = [self setUpPickerView];
    self.rightPickerView.tag = 2;
    
    self.labelMiddle = [[UILabel alloc] init];
    self.labelMiddle.text = @"至";
    self.labelMiddle.textAlignment = NSTextAlignmentCenter;
    
    self.naviagtionBar = [[UINavigationBar alloc] init];
    self.navigationItem = [[UINavigationItem alloc] initWithTitle:@"年龄段选择"];
    [self.naviagtionBar setBackgroundColor:[UIColor redColor]];
    self.naviagtionBar.items = [NSArray arrayWithObject:self.navigationItem];
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClicked:)];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonClicked:)];

    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    [self addSubview:self.naviagtionBar];
    
    [self addSubview:self.labelMiddle];
    [self addSubview:self.leftPickerView];
    [self addSubview:self.rightPickerView];
    
    self.startAgeString = @"0岁";
    self.endAgeString = @"0岁";
    
    self.navigationItem.rightBarButtonItem.enabled = NO;

}
-(void)cancelButtonClicked:(UIBarButtonItem*)btnItem
{
    /// 隐藏view
}
-(void)saveButtonClicked:(UIBarButtonItem*)btnItem
{
    NSString *resultStr = [NSString stringWithFormat:@"%@ - %@",self.startAgeString,self.endAgeString];
    [self.GGCustomPickerViewDelegate selectedAgeSegmentIs:resultStr];
}

-(UIPickerView*)setUpPickerView
{
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    
  //  pickerView.backgroundColor = [UIColor redColor];
    return pickerView;
    
}
-(void)layoutSubviews
{
    [super  layoutSubviews];
    CGRect tempRect = self.frame;
    CGRect tempFrame1 = CGRectMake(leftMargin,44, tempRect.size.width/2-labelWidth/2 - leftMargin, tempRect.size.height - 44);

    CGRect tempFrame2 = CGRectMake(tempRect.size.width/2 +labelWidth/2 ,44, tempRect.size.width/2-labelWidth/2 - leftMargin, tempRect.size.height - 44);
    
    CGRect tempFrame3 = CGRectMake(tempRect.size.width/2-labelWidth/2, tempRect.size.height/2, labelWidth, 25);
    
    CGRect tempFrame4 = CGRectMake(0, 0, tempRect.size.width, 44);
    [self.naviagtionBar setFrame:tempFrame4];
    
    [self.leftPickerView setFrame:tempFrame1];
    [self.rightPickerView setFrame:tempFrame2];
    [self.labelMiddle setFrame:tempFrame3];
    
    CGPoint centerL = self.leftPickerView.center;
    centerL.y = tempRect.size.height/2 + 44/2;
    
    CGPoint centerR = self.rightPickerView.center;
    centerR.y = tempRect.size.height/2 + 44/2;

    CGPoint centerLabel = self.labelMiddle.center;
    centerLabel.y = tempRect.size.height/2 + 44/2;

    self.leftPickerView.center = centerL;
    self.rightPickerView.center = centerR;
    self.labelMiddle.center = centerLabel;
}

#pragma mask - picker view delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.dataSourceOne.count != 0 && self.dataSourceTwo.count != 0) {
        if (pickerView == self.leftPickerView) {
            return self.dataSourceOne.count;
        }else {
            return self.dataSourceTwo.count;
        }
    }else {
        return maxAge;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.dataSourceOne.count != 0 && self.dataSourceTwo.count != 0) {
        if (pickerView == self.leftPickerView) {
            return [self.dataSourceOne objectAtIndex:row];
        }else {
            return [self.dataSourceTwo objectAtIndex:row];
        }
    }else {
        return [NSString stringWithFormat:@"%@",@(row)];
    }

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.leftPickerView) {
        self.startAgeString =[NSString stringWithFormat:@"%@岁",@([pickerView selectedRowInComponent:0])];
    }else {
        self.endAgeString =[NSString stringWithFormat:@"%@岁",@([pickerView selectedRowInComponent:0])];
    }
    
    if([self.startAgeString integerValue] == maxAge){
        [self.rightPickerView selectRow:[self.startAgeString integerValue] inComponent:0 animated:YES];
        
    }else if([self.startAgeString integerValue] > [self.endAgeString integerValue]){
        [self.rightPickerView selectRow:[self.startAgeString integerValue]+ 1 inComponent:0 animated:YES];
        
        self.endAgeString =[NSString stringWithFormat:@"%@岁",@([pickerView selectedRowInComponent:0])];
    }

    self.navigationItem.rightBarButtonItem.enabled = YES;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
