//
//  CKHttpClient.m
//  MedCaseHttpTest
//
//  Created by Apple on 15/4/9.
//  Copyright (c) 2015年 iHefe. All rights reserved.
//

#import "CKHttpClient.h"

@implementation CKHttpClient

static CKHttpClient* client = nil;

+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[CKHttpClient alloc] initWithBaseURL:[NSURL URLWithString:ServerURL]];
        AFJSONRequestSerializer *jsonSerializer = [[AFJSONRequestSerializer alloc] init];
        client.requestSerializer = jsonSerializer;
    });
    return client;
}

/// post template to server
-(void)postTemplateToServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [HttpClient POST:@"emr" parameters:dic success:success failure:failure];
}
/// get  disease from server
-(void)getDiseaseFromServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [HttpClient GET:@"diseases" parameters:dic success:success failure:failure];
}

///get main sympyoms
-(void)getMainSympyomsFromServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [HttpClient GET:@"symptoms" parameters:dic success:success failure:failure];
}

///get labtests
-(void)getLabtestsFromServerWithDicParam:(NSDictionary*)dic  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    [HttpClient GET:@"labtests" parameters:dic success:success failure:failure];
}


@end
