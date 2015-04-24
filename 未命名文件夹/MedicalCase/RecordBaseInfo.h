//
//  RecordBaseInfo.h
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/24.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Doctor, Patient;

@interface RecordBaseInfo : NSManagedObject

@property (nonatomic, retain) NSDate * createdTime;
@property (nonatomic, retain) NSDate * lastModifyTime;
@property (nonatomic, retain) NSDate * archivedTime;
@property (nonatomic, retain) NSString * casePresenter;
@property (nonatomic, retain) NSString * caseContent;
@property (nonatomic, retain) NSString * caseType;
@property (nonatomic, retain) NSString * caseState;
@property (nonatomic, retain) NSOrderedSet *doctors;
@property (nonatomic, retain) Patient *patient;
@end

@interface RecordBaseInfo (CoreDataGeneratedAccessors)
+(NSString*)entityName;

- (void)insertObject:(Doctor *)value inDoctorsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDoctorsAtIndex:(NSUInteger)idx;
- (void)insertDoctors:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDoctorsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDoctorsAtIndex:(NSUInteger)idx withObject:(Doctor *)value;
- (void)replaceDoctorsAtIndexes:(NSIndexSet *)indexes withDoctors:(NSArray *)values;
- (void)addDoctorsObject:(Doctor *)value;
- (void)removeDoctorsObject:(Doctor *)value;
- (void)addDoctors:(NSOrderedSet *)values;
- (void)removeDoctors:(NSOrderedSet *)values;
@end
