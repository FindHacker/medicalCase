//
//  CKHttpClient.h
//  MedCaseHttpTest
//
//  Created by Apple on 15/4/9.
//  Copyright (c) 2015年 iHefe. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define ServerURL @"http://192.168.10.113:5000/"
#define HttpClient [CKHttpClient getInstance]

@interface CKHttpClient : AFHTTPRequestOperationManager
+ (instancetype)getInstance;

-(void)postTemplateToServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(void)getDiseaseFromServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
-(void)getMainSympyomsFromServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
