//
//  WriteMedicalRecordVCViewController.h
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/21.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLKMultiTableView.h"

@protocol WriteMedicalRecordVCViewControllerDelegate <NSObject>

@required
-(void)didWriteStringToMedicalRecord:(NSString*)writeString;
@end

@interface WriteMedicalRecordVCViewController : UIViewController
@property (weak, nonatomic) IBOutlet WLKMultiTableView *MultiTableView;
@property (strong,nonatomic) NSString *labelString;

@property (nonatomic,weak) id <WriteMedicalRecordVCViewControllerDelegate> WriteDelegate;
@property (nonatomic,strong) UIView *rightSideSlideView;

@property (nonatomic) BOOL  rightSlideViewFlag;
@end
