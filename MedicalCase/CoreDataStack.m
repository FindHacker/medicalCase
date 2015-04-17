//
//  CoreDataStack.m
//  CoreData
//
//  Created by GK on 15/4/4.
//  Copyright (c) 2015年 GK. All rights reserved.
//

#import "CoreDataStack.h"
#import "Node.h"
#import "ParentNode.h"
#import "Template.h"

@implementation CoreDataStack

static NSString *momdName = @"MedicalCase";

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.apphouse.CoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
+(CoreDataStack *)sharedCoreDataStack
{
    static CoreDataStack *coreDataStack;
    static dispatch_once_t token;
    
    dispatch_once(&token,^{
        coreDataStack = [[CoreDataStack alloc] initSingle];
        //load data from plist
        [coreDataStack createManagedObjectFromPlistData];
        
    });
    return coreDataStack;
}
-(instancetype)initSingle
{
    if(self = [super init])
    {
        //load data from plist to core data
    
    }
    return self;

}
-(instancetype)init
{
    return  [CoreDataStack sharedCoreDataStack];
}
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:momdName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MedicalCase.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
#pragma mask - create entity or NSmanagedObject with data
-(Node *)createManagedObjectEntityForNameNodeAndWithDicData:(NSDictionary*)dicData
{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName: [Node entityName]inManagedObjectContext:self.managedObjectContext];
    Node *node = [[Node alloc] initWithEntity:entityDesc insertIntoManagedObjectContext:self.managedObjectContext];
    
    if ([dicData.allKeys containsObject:@"nodeName"]) {
        node.nodeName =[dicData objectForKey:@"nodeName"];
    }
    if ([dicData.allKeys containsObject:@"nodeType"]) {
        node.nodeType = [dicData objectForKey:@"nodeType"]; //0 : from origin data ,1 : from custom data
    }else {
        node.nodeType = [NSNumber numberWithInt:0];
    }
    if ([dicData.allKeys containsObject:@"nodeContent"]) {
        node.nodeContent = [dicData objectForKey:@"nodeContent"];
    }else {
        node.nodeContent = node.nodeName;
    }
    if([dicData.allKeys containsObject:@"nodeIndex"]){
        node.nodeIndex = [dicData objectForKey:@"nodeIndex"];
    }else {
        node.nodeIndex = [NSNumber numberWithInt:0];
    }
    
    if ([node.nodeName isEqualToString:@"入院记录"]) {
        node.nodeIdentifier =  @"ihefe101";
    }
    if ([dicData.allKeys containsObject:@"childNode"]) {
        NSArray *childArray = [dicData objectForKey:@"childNode"];
        
        NSEntityDescription *entityDescP = [NSEntityDescription entityForName: [ParentNode entityName]inManagedObjectContext:self.managedObjectContext];
        ParentNode *nodeP = [[ParentNode alloc] initWithEntity:entityDescP insertIntoManagedObjectContext:self.managedObjectContext];
        nodeP.nodeName = node.nodeName;
    
        NSMutableOrderedSet *childNodes = [[NSMutableOrderedSet alloc] initWithOrderedSet:nodeP.nodes];
        
        NSUInteger index = 1;
        for (NSDictionary *subNodeDic in childArray) {
            node.hasSubNode = [NSNumber numberWithBool:YES] ;
            Node *subNode = [self createManagedObjectEntityForNameNodeAndWithDicData:subNodeDic];
        
            subNode.nodeIdentifier = [node.nodeIdentifier stringByAppendingString:[NSString stringWithFormat:@"%@",index > 10 ? @(index) : [NSString stringWithFormat:@"0%@",@(index)]]];
            [childNodes addObject:subNode];
            
            index += 1;

        }
        nodeP.nodes =[[NSOrderedSet alloc] initWithOrderedSet:childNodes];
    }
    return node;
}
#pragma mask - create managed object Template
///create managed object Template
-(void)createManagedObjectTemplateWithDic:(NSDictionary*)dic  ForNodeWithNodeName:(NSString *)nodeName
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nodeName = %@",nodeName];
    NSArray *tempArray = [self fetchNSManagedObjectEntityWithName:[Node entityName] withNSPredicate:predicate setUpFetchRequestResultType:NSCountResultType isSetUpResultType:NO setUpFetchRequestSortDescriptors:nil isSetupSortDescriptors:NO];
    
    Node *node = (Node*)[tempArray firstObject];
    
    NSEntityDescription *templateDesc = [NSEntityDescription entityForName: [Template entityName]inManagedObjectContext:self.managedObjectContext];
    Template *template = [[Template alloc] initWithEntity:templateDesc insertIntoManagedObjectContext:self.managedObjectContext];
    template.node = node;
    
    if ([dic.allKeys containsObject:@"condition"]) {
        template.condition = dic[@"condition"];
    }
    if ([dic.allKeys containsObject:@"content"]) {
        template.content = dic[@"content"];
    }
    if ([dic.allKeys containsObject:@"gender"]) {
        template.gender = dic[@"gender"];
    }
    if ([dic.allKeys containsObject:@"ageHigh"]) {
        template.ageHigh = dic[@"ageHigh"];
    }
    if ([dic.allKeys containsObject:@"admittingDiagnosis"]) {
        template.admittingDiagnosis = dic[@"admittingDiagnosis"];
    }
    if ([dic.allKeys containsObject:@"simultaneousPhenomenon"]) {
        template.simultaneousPhenomenon  = dic[@"simultaneousPhenomenon"];
    }
    if ([dic.allKeys containsObject:@"ageLow"]) {
        template.ageLow = dic[@"ageLow"];
    }
    if ([dic.allKeys containsObject:@"cardinalSymptom"]) {
        template.cardinalSymptom = dic[@"cardinalSymptom"];
    }
    
    if ([dic.allKeys containsObject:@"nodeID"]) {
        template.nodeID = dic[@"nodeID"];
    }
    if ([dic.allKeys containsObject:@"updatedTime"]) {
        template.nodeID = dic[@"updatedTime"];
    }
    NSDate *newDate = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSTimeInterval interval = [zone secondsFromGMTForDate:newDate];
//    NSDate *localDate = [newDate dateByAddingTimeInterval:interval];
    template.createDate = newDate;
    template.section = [self getYearAndMonthWithDateStr:newDate];

    ///for testpo
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    NSDate *d = [f dateFromString:@"2012-04-08 12:50:54.601"];
//    template.createDate = d;
//    template.section = [self getYearAndMonthWithDateStr:d];

    [self saveContext];
}
-(NSString*)getYearAndMonthWithDateStr:(NSDate*)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    [formatter setTimeZone:zone];
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

#pragma mask - load data and create managed object from plist
-(void)createManagedObjectFromPlistData
{
    //load data from plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"coreDataTestData" ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [self printDictionary:dataDic];
    
    //if fetch result array count is 0 ,create managed object
    int count = [self fetchNSManagedObjectEntityCountWithName:@"Node"];
    if(count == 0) {
        //create managed object
        [self createManagedObjectEntityForNameNodeAndWithDicData:dataDic];
        [self saveContext];
    }

    //for test fetch
    NSArray *testArray = [self fetchNSManagedObjectEntityWithName:@"Node" withNSPredicate:nil setUpFetchRequestResultType:NSManagedObjectIDResultType isSetUpResultType:NO setUpFetchRequestSortDescriptors:nil isSetupSortDescriptors:NO];
    [self printArray:testArray];
}
#pragma  mask - fetch NSmanagedObject Template
///fetch NSmanagedObject Template
-(NSArray*)fetchNSmanagedObjectEntityWithName:(NSString*)entityName
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nodeName = %@",entityName];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:YES];
    NSArray *tempArray = [self fetchNSManagedObjectEntityWithName:[Node entityName] withNSPredicate:predicate setUpFetchRequestResultType:NSCountResultType isSetUpResultType:NO setUpFetchRequestSortDescriptors:@[sortDescriptor] isSetupSortDescriptors:NO];
    
    if ([[tempArray firstObject] isKindOfClass:[Node class]]) {
        Node *tempNode = (Node*)[tempArray firstObject];
        
        array = [[NSMutableArray alloc] initWithArray:tempNode.templates.array];
    }
    return array;
}
#pragma mask - fetch NSmanagedObject count
-(int)fetchNSManagedObjectEntityCountWithName:(NSString*)entityName
{
    int count = 0;
    
    NSArray *countArray = [self fetchNSManagedObjectEntityWithName:entityName withNSPredicate:nil setUpFetchRequestResultType:NSCountResultType isSetUpResultType:YES setUpFetchRequestSortDescriptors:nil isSetupSortDescriptors:NO];
    
    count = [[countArray firstObject] intValue];
    
    return count;
}
#pragma mask - fetch NSmanagedObject
-(NSArray*)fetchNSManagedObjectEntityWithName:(NSString*)entityName withNSPredicate:(NSPredicate*)predicate setUpFetchRequestResultType:(NSFetchRequestResultType)fetchResultType isSetUpResultType:(BOOL)isSetUpResultType setUpFetchRequestSortDescriptors:(NSArray*)sortDescriptors isSetupSortDescriptors:(BOOL)isSetupSortDescriptors
{
    NSMutableArray *resultArray;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    if (predicate != nil) {
        fetchRequest.predicate = predicate;
    }

    if (isSetUpResultType) {
        fetchRequest.resultType = fetchResultType;
    }
    
    if (isSetupSortDescriptors) {
        fetchRequest.sortDescriptors = sortDescriptors;
    }
    NSError *error;
    
    NSArray *tempArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(error){
        NSLog(@"fetch error %@",error.description);
    }
    if (tempArray.count == 0) {
        NSLog(@"you should first create entity : %@,then fetch it",entityName);
        NSLog(@"fetch error");
        NSLog(@"or because this is first run,so take easy");
        
    }
    resultArray = [[NSMutableArray alloc] initWithArray:tempArray];
    
    return resultArray ;
}
#pragma mask - ii
-(void)printDictionary:(NSDictionary*)dic
{
    for (NSString *key in dic.allKeys) {
        
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSLog(@"%@ : %@",key,value);
        }else {
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray *tempArray = (NSArray*)value;
                NSLog(@"%@ : %@",key,[NSNumber numberWithLong:tempArray.count]);
            }
        }
    }
}
#pragma mask - helper
-(void)printArray:(NSArray*)arr
{
    for (id idObj in arr) {
        if ([idObj isKindOfClass:[Node class]]) {
            Node *tempNode = (Node*)idObj;
            NSLog(@"nodeName is %@",tempNode.nodeName);
            NSLog(@"nodeContent is %@",tempNode.nodeContent);
            NSLog(@"nodeIndex is %@",tempNode.nodeIndex);
            NSLog(@"nodeType is %@",tempNode.nodeType);
           // NSLog(@"node childs count is %@",[[NSNumber alloc] initWithLong:tempNode.nodes.count ]);
        }
    }
}
@end
