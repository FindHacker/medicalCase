//
//  PullCellData.h
//  Docter
//
//  Created by luohong on 14-4-21.
//  Copyright (c) 2014年 shuai huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PullCellData : NSObject

@property (nonatomic, strong) NSString *reportName;
@property (nonatomic, strong) NSArray *test_nos;
@property (nonatomic, strong) NSDictionary *testDic;

@property (nonatomic,strong) NSString *blxh;//病历序号

@property (nonatomic,strong) NSString *oper_id;//手术号

@property (nonatomic,strong)NSArray *blxhs;//病历序号

@end
