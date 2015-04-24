//
//  SectionButton.m
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import "SectionButton.h"



@interface SectionButton ()
{
    UIImage *leftImage;
    UIImage *oneImage;
    
    UIImage *selectImage;
    UIImage *noSelectImage;
    
    UIImageView *leftImageView;
    UIImageView *rightImageView;
}


@end

@implementation SectionButton

@synthesize open;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        open = NO;   //默认设置关闭
        
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:18];
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
//        [self setTitleColor:IH_TBC forState:UIControlStateNormal];
        [self setTitleColor:LeftNavigationColor forState:UIControlStateNormal];
//        self.titleLabel.shadowColor = [UIColor redColor];
//        self.titleLabel.shadowOffset = CGSizeMake(1.0f, 0.0f);
        
        oneImage = [UIImage imageNamed:@"Navigation.png"];
        
        selectImage = [UIImage imageNamed:@"Select.png"];
        noSelectImage = [UIImage imageNamed:@"NoSelect.png"];
    }
    return self;
}

- (void)setLeftAndRightImageView:(UIImage *)image
{
    if (self.tag == 0)
    {
        leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 50.0f)];
        rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 50.0f, 0.0f, 50.0f, 50.0f)];
        
        leftImageView.image = nil;
        rightImageView.image = oneImage;
    }
    else
    {
        leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 50.0f)];
        rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 24.0f, 0.0f, 24.0f, 50.0f)];
        
        leftImage = image;
        
        leftImageView.image = leftImage;
        rightImageView.image = noSelectImage;
    }
    
    [self addSubview:leftImageView];
    [self addSubview:rightImageView];
}

- (void)setOpen:(BOOL)_open
{
    open = _open;
    
    if (self.tag != 0)
    {
        if (open == YES)
        {
            rightImageView.image = selectImage;
        }
        else
        {
            rightImageView.image = noSelectImage;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 161.0f / 255.0f, 167.0f / 255.0f, 166.0f / 255.0f, 1.0f);
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
