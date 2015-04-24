//
//  SeparateView.m
//  PullDownMenu
//
//  Created by lsw on 14-4-15.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import "SeparateView.h"

@implementation SeparateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 194.0f / 255.0f, 197.0f / 255.0f, 197.0f / 255.0f, 0.9f);
    CGContextSetLineWidth(context, 0.5f);
    CGContextMoveToPoint(context, 0.0f, self.frame.size.height);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
