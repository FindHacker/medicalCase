//
//  NSDate+Helper.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/16.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

///得到当前系统时间
-(NSDate*)getSystemCurrentTime
{
    NSDate *newDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [zone secondsFromGMTForDate:newDate];
    NSDate *localDate = [newDate dateByAddingTimeInterval:interval];

    return localDate;
}

-(NSString*)YearAndMonthWithDate:(NSDate*)transformDate
{
    NSString *YearAndMonthSTring;
    
    
    
    return YearAndMonthSTring;
}
@end
