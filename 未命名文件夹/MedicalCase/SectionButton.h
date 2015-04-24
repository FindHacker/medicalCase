//
//  SectionButton.h
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionButton : UIButton

#define FontSize [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]

#define LeftNavigationColor [UIColor colorWithRed:0.0f green:99.0f / 255.0f blue:197.0 / 255.0f alpha:1.0f]
#define FontSize [UIFont fontWithName:@"HelveticaNeue-Thin" size:16.0f]
#define TextColor [UIColor colorWithRed:51.0f / 255.0f green:50.0f / 255.0f blue:29.0f / 255.0f alpha:1.0f]

@property (nonatomic, assign) BOOL open;        //判断section是否打开

- (void)setLeftAndRightImageView:(UIImage *)image;

@end
