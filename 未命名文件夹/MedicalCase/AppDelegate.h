//
//  AppDelegate.h
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/1.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "IHMsgSocket.h"
#import "PPRevealSideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,PPRevealSideViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) IHMsgSocket *socket;
@property (strong, nonatomic) PPRevealSideViewController *revealSideViewController;


@end

