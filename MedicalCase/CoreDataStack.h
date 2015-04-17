//
//  CoreDataStack.h
//  CoreData
//
//  Created by GK on 15/4/4.
//  Copyright (c) 2015年 GK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

-(NSArray*)fetchNSManagedObjectEntityWithName:(NSString*)entityName withNSPredicate:(NSPredicate*)predicate setUpFetchRequestResultType:(NSFetchRequestResultType)fetchResultType isSetUpResultType:(BOOL)isSetUpResultType setUpFetchRequestSortDescriptors:(NSArray*)sortDescriptors isSetupSortDescriptors:(BOOL)isSetupSortDescriptors;

-(void)createManagedObjectTemplateWithDic:(NSDictionary*)dic  ForNodeWithNodeName:(NSString *)nodeName;

///detch template
-(NSArray*)fetchNSmanagedObjectEntityWithName:(NSString*)entityName;

@end
