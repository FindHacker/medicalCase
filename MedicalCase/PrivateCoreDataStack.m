//
//  PrivateCoreDataStack.m
//  MedicalCase
//
//  Created by ihefe-JF on 15/4/9.
//  Copyright (c) 2015年 ihefe. All rights reserved.
//

#import "PrivateCoreDataStack.h"

@interface PrivateCoreDataStack()
@property (readonly, strong, nonatomic) NSManagedObjectContext *privateManagedObjectContext;
@end
@implementation PrivateCoreDataStack

@synthesize privateManagedObjectContext = _privateManagedObjectContext;
-(instancetype)init
{
    self  = [super init];
    
    if (self) {
        
    }
    
    return self;
}
-(NSManagedObjectContext *)privateManagedObjectContext
{
    if(!_privateManagedObjectContext){
        _privateManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _privateManagedObjectContext.persistentStoreCoordinator = self.managedObjectContext.persistentStoreCoordinator;
    }
    return _privateManagedObjectContext;
}
-(void)asyncCreateNSManagedObject
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"病历" ofType:@"opml"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //if fetch result array count is 0 ,create managed object
    int count = [self fetchNSManagedObjectEntityCountWithName:[TestNode entityName]];
    if(count == 0) {
        //create managed object
        [self.privateManagedObjectContext performBlock:^{
            [self createManagedObjectEntityForNameNodeAndWithDicData:dataDic];
            [self saveContext];
        }];
    }
    
}
#pragma mask - fetch NSmanagedObject count
-(int)fetchNSManagedObjectEntityCountWithName:(NSString*)entityName
{
    int count = 0;
    
    NSArray *countArray = [self fetchNSManagedObjectEntityWithName:entityName withNSPredicate:nil setUpFetchRequestResultType:NSCountResultType isSetUpResultType:YES setUpFetchRequestSortDescriptors:nil isSetupSortDescriptors:NO];
    
    count = [[countArray firstObject] intValue];
    
    return count;
}

-(TestNode *)createManagedObjectEntityForNameNodeAndWithDicData:(NSDictionary*)dicData
{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName: [TestNode entityName]inManagedObjectContext:self.managedObjectContext];
    TestNode *node = [[TestNode alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:self.privateManagedObjectContext];
    
    if ([dicData.allKeys containsObject:@"nodeName"]) {
        node.nodeName =[dicData objectForKey:@"nodeName"];
    }
    if ([dicData.allKeys containsObject:@"nodeContent"]) {
        node.nodeContent = [dicData objectForKey:@"nodeContent"];
    }else {
        node.nodeContent = node.nodeName;
    }
    
    if ([dicData.allKeys containsObject:@"childNode"]) {
        NSArray *childArray = [dicData objectForKey:@"childNode"];
        
        NSEntityDescription *entityDescP = [NSEntityDescription entityForName: [TestParentNode entityName]inManagedObjectContext:self.managedObjectContext];
        TestParentNode *nodeP = [[TestParentNode alloc] initWithEntity:entityDescP insertIntoManagedObjectContext:self.managedObjectContext];
        nodeP.nodeName = node.nodeName;
        
        NSMutableOrderedSet *childNodes = [[NSMutableOrderedSet alloc] initWithOrderedSet:nodeP.testNodes];
        
        for (NSDictionary *subNodeDic in childArray) {
            node.hasSubNode = [NSNumber numberWithBool:YES] ;
            TestNode *subNode = [self createManagedObjectEntityForNameNodeAndWithDicData:subNodeDic];
            [childNodes addObject:subNode];
        }
        nodeP.testNodes =[[NSOrderedSet alloc] initWithOrderedSet:childNodes];
    }
    return node;
}


@end
