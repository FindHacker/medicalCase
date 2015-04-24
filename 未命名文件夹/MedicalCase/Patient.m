//
//  Patient.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/24.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "Patient.h"
#import "Doctor.h"
#import "RecordBaseInfo.h"


@implementation Patient

@dynamic pID;
@dynamic pName;
@dynamic pGender;
@dynamic pAge;
@dynamic pCity;
@dynamic pProvince;
@dynamic pDetailAddress;
@dynamic pDept;
@dynamic pBedNum;
@dynamic pNation;
@dynamic pProfession;
@dynamic pMaritalStatus;
@dynamic pMobileNum;
@dynamic pLinkman;
@dynamic pLinkmanMobileNum;
@dynamic pCountOfHospitalized;
@dynamic patientState;
@dynamic medicalCase;
@dynamic doctor;
+(NSString*)entityName
{
    return @"entityName";
}

@end
