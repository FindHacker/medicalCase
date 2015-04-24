//
//  MenuTableCell.m
//  PullDownMenu
//
//  Created by lsw on 14-4-14.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

#import "MenuTableCell.h"

@interface MenuTableCell ()
{
    SeparateView *sepView;
}

@end

@implementation MenuTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        self.alpha = 0.5f;
//        self.textLabel.alpha = 0.9f;
//        self.textLabel.backgroundColor = [UIColor colorWithRed:251.0f / 255.0f green:251.0f / 255.0f blue:251.0f / 255.0f alpha:1.0f];
        
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = LeftNavigationColor;
//        self.selectedBackgroundView = view;
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.autoresizesSubviews = YES;
        
        self.textLabel.font = FontSize;
        self.textLabel.textColor = TextColor;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
//        self.textLabel.shadowColor = [UIColor whiteColor];
//        self.textLabel.shadowOffset = CGSizeMake(1.0f, 0.0f);
        
        sepView = [[SeparateView alloc] initWithFrame:CGRectMake(0.0f, self.frame.size.height - 1.0f, self.frame.size.width, 1.0f)];
        sepView.backgroundColor = [UIColor clearColor];
        [self addSubview:sepView];
    }
    return self;
}

- (void)changeCellContent
{
//    sepView.center = CGPointMake(self.frame.size.width / 2.0f, self.frame.size.height - 1.0f);
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
