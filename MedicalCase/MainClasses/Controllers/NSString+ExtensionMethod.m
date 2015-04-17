//
//  NSString+ExtensionMethod.m
//  MedCase
//
//  Created by ihefe-JF on 15/2/10.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "NSString+ExtensionMethod.h"


@implementation NSString (ExtensionMethod)

-(NSString*)removeWhitespaceAtHeadAndTail
{
   return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString *)ExtrusionBlankBetweenWords
{
    NSString *tempString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *components = [tempString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> '' "]];
    
    tempString = [components componentsJoinedByString:@" "];
    
    return tempString;
}



@end
