//
//  Doctor.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/24.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"
#import "RecordBaseInfo.h"


@implementation Doctor

@dynamic dID;
@dynamic dName;
@dynamic dProfessionalTitle;
@dynamic dept;
@dynamic medicalTeam;
@dynamic isResident;
@dynamic isAttendingPhysican;
@dynamic isChiefPhysician;
@dynamic patients;
@dynamic medicalCases;
+(NSString*)entityName
{
    return @"Doctor";
}
@end
