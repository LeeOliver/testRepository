//
//  SJNetworkService.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

@interface SJNetworkService : NSObject
{
@private
    NSOperationQueue                *_asyncRequest2ServerQueue;
    NSOperationQueue                *_bigFileDLorULQueue;
    CFMutableDictionaryRef          _asyncRequestInfo;
}
+(SJNetworkService *)shareInstance;

- (ASIFormDataRequest *)asynRequestWithMethodName:(NSString *)methodName
                                     andGetParams:(NSDictionary *)getParams
                                    andPostParams:(NSDictionary *)postParams
                                        andTarget:(id)aTarget
                                  andSuccSelector:(SEL)aSuccSel
                                  andFailSelector:(SEL)aFailSel;

- (ASIHTTPRequest *)asynRequestWithMethodName:(NSString *)methodName
                                 andGetParams:(NSDictionary *)getParams
                                andPostParams:(NSDictionary *)postParams
                                 andSuccBlock:(void (^)(ASIHTTPRequest *))succBlock
                                 andFailBlock:(void (^)(ASIHTTPRequest *))failBlock;


- (NSDictionary *)syncRequestWithMethodName:(NSString *)methodName
                               andGetParams:(NSDictionary *)getParams
                              andPostParams:(NSDictionary *)postParams;

@end
