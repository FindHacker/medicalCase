//
//  NSString+ExtensionMethod.h
//  MedCase
//
//  Created by ihefe-JF on 15/2/10.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExtensionMethod)

/**
 * 去除首尾空格
 */
-(NSString*)removeWhitespaceAtHeadAndTail;

/**
 * 去除单词之间的多余空格和首尾空格<仅仅适用于英语这种用空格分隔的语言>
 * 然后再把各个单词用空格拼接起来
 */
-(NSString*)ExtrusionBlankBetweenWords;

@end
