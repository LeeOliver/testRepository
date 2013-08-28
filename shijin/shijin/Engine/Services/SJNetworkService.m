//
//  SJNetworkService.m
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJNetworkService.h"

@implementation SJNetworkService
static SJNetworkService * sharedSJNetworkService = NULL;

+(SJNetworkService *)shareInstance{
    @synchronized(self){
        if(sharedSJNetworkService == NULL){
            sharedSJNetworkService = [[SJNetworkService alloc] init];
        }
        
        return sharedSJNetworkService;
    }
}

- (id) init{
    if (self = [super init])
    {
        _asyncRequest2ServerQueue    = [[NSOperationQueue alloc] init];
        [_asyncRequest2ServerQueue setMaxConcurrentOperationCount:5]; //not too big not too small
        _bigFileDLorULQueue     = [[NSOperationQueue alloc] init];
        [_bigFileDLorULQueue setMaxConcurrentOperationCount:1];
        _asyncRequestInfo        = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return self;
}

#pragma mark utility base network
- (ASIFormDataRequest*)generateRequestWithMethodName:(NSString *)methodName
                                        andGetParams:(NSDictionary *)getParams
                                       andPostParams:(NSDictionary *)postParams
{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@%@.php",WEBAPI,methodName];
    if (getParams && [getParams count]>0)
    {
        [urlStr appendString:@"?"];
    }
    for (NSString *key in [getParams allKeys])
    {
        [urlStr appendFormat:@"%@=%@&",key,[getParams objectForKey:key]];
    }
    NSString *iUrlStr;
    if (!getParams)
    {
        iUrlStr = urlStr;
    }
    else
    {
        iUrlStr = [urlStr substringToIndex:[urlStr length]-1];
    }
    
    ASIFormDataRequest *tRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:iUrlStr]];
    
    [tRequest setTimeOutSeconds:30];
    [tRequest setDelegate:self];
    
    for (int i = 0; i<[[postParams allKeys]count]; i++)
    {
        NSString *key = [[postParams allKeys] objectAtIndex:i];
        [tRequest addPostValue:[postParams objectForKey:key] forKey:key];
    }
    
    return tRequest;
    
}


- (ASIHTTPRequest *)asynRequestWithMethodName:(NSString *)methodName
                                 andGetParams:(NSDictionary *)getParams
                                andPostParams:(NSDictionary *)postParams
                                 andSuccBlock:(void (^)(ASIHTTPRequest *))succBlock
                                 andFailBlock:(void (^)(ASIHTTPRequest *))failBlock
{
    // this is specail for not comiple warning
    ASIHTTPRequest *tRequest = [self generateRequestWithMethodName:methodName
                                                      andGetParams:getParams
                                                     andPostParams:postParams];
    __unsafe_unretained ASIHTTPRequest *request = tRequest;
    // this is specail for not comiple warning
    
    [request setCompletionBlock:^{
        if (succBlock != NULL){
            succBlock (request);
        }
    }];
    
    [request setFailedBlock:^{
//        DDLogError(@"WebAPI Error request:%@ response:%@",request.url, request.responseString);
        
        if (failBlock != NULL) {
            failBlock (request);
        }
    }];
//    DDLogInfo(@"FeedAPIRequest:%@",tRequest.url);
    [tRequest startAsynchronous];
    return tRequest;
}

- (ASIFormDataRequest *)asynRequestWithMethodName:(NSString *)methodName
                                     andGetParams:(NSDictionary *)getParams
                                    andPostParams:(NSDictionary *)postParams
                                        andTarget:(id)aTarget
                                  andSuccSelector:(SEL)aSuccSel
                                  andFailSelector:(SEL)aFailSel
{
    ASIFormDataRequest *tRequest = [self generateRequestWithMethodName:methodName
                                                          andGetParams:getParams
                                                         andPostParams:postParams];
    [self addRequestInfo:tRequest
                  target:aTarget
         successSelector:aSuccSel
           errorSelector:aFailSel];
    [_asyncRequest2ServerQueue addOperation:tRequest];
    return tRequest;
}

- (NSDictionary *)syncRequestWithMethodName:(NSString *)methodName
                               andGetParams:(NSDictionary *)getParams
                              andPostParams:(NSDictionary *)postParams
{
    
    ASIFormDataRequest *tRequest = [self generateRequestWithMethodName:methodName
                                                          andGetParams:getParams
                                                         andPostParams:postParams];
    [tRequest startSynchronous];
//    DDLogInfo(@"request:%@",tRequest.url);
    NSDictionary *returnData = [[tRequest responseData] objectFromJSONData];
    return returnData;
}

- (BOOL)addRequestInfo:(ASIHTTPRequest *)request
                target:(id)aTarget
       successSelector:(SEL)successSelector
         errorSelector:(SEL)errorSelector {
    NSMutableDictionary *requestInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        [NSValue valueWithNonretainedObject:aTarget], CALLBACK_TARGET,
                                        [NSValue valueWithPointer:successSelector], CALLBACK_SUC_SEL,
                                        [NSValue valueWithPointer:errorSelector], CALLBACK_FAIL_SEL,
                                        request, REQUEST,
                                        nil];
    CFDictionaryAddValue(_asyncRequestInfo, (__bridge const void *)(request), (__bridge const void *)(requestInfo));
    return YES;
}

@end
