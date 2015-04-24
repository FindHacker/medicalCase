//
//  RecordBaseInfo.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/24.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "RecordBaseInfo.h"
#import "Doctor.h"
#import "Patient.h"


@implementation RecordBaseInfo

@dynamic createdTime;
@dynamic lastModifyTime;
@dynamic archivedTime;
@dynamic casePresenter;
@dynamic caseContent;
@dynamic caseType;
@dynamic caseState;
@dynamic doctors;
@dynamic patient;
+(NSString*)entityName{
    return @"RecordBaseInfo";
}

@end
