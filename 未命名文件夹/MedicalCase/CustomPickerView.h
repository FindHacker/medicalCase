//
//  CustomPickerView.h
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/17.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomPickerViewDelegate <NSObject>

@required
-(void)selectedAgeSegmentIs:(NSString*)ageString;

@end

@interface CustomPickerView : UIView
@property (nonatomic,strong) NSMutableArray *dataSourceOne;
@property (nonatomic,strong) NSMutableArray *dataSourceTwo;

@property (nonatomic,weak) id<CustomPickerViewDelegate> GGCustomPickerViewDelegate;
@end
