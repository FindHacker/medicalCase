//
//  Patient.h
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/24.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Doctor, RecordBaseInfo;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSString * pID;
@property (nonatomic, retain) NSString * pName;
@property (nonatomic, retain) NSString * pGender;
@property (nonatomic, retain) NSString * pAge;
@property (nonatomic, retain) NSString * pCity;
@property (nonatomic, retain) NSString * pProvince;
@property (nonatomic, retain) NSString * pDetailAddress;
@property (nonatomic, retain) NSString * pDept;
@property (nonatomic, retain) NSString * pBedNum;
@property (nonatomic, retain) NSString * pNation;
@property (nonatomic, retain) NSString * pProfession;
@property (nonatomic, retain) NSString * pMaritalStatus;
@property (nonatomic, retain) NSString * pMobileNum;
@property (nonatomic, retain) NSString * pLinkman;
@property (nonatomic, retain) NSString * pLinkmanMobileNum;
@property (nonatomic, retain) NSString * pCountOfHospitalized;
@property (nonatomic, retain) NSString * patientState;
@property (nonatomic, retain) RecordBaseInfo *medicalCase;
@property (nonatomic, retain) Doctor *doctor;

+(NSString*)entityName;

@end
