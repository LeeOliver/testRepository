//
//  SJPushEngine.m
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJPushEngine.h"

@implementation SJPushEngine
@synthesize tokenStr            = _tokenStr;

static SJPushEngine * sharedPushEngine = NULL;

+(SJPushEngine *)shareInstance{
    @synchronized(self){
        if(sharedPushEngine == NULL){
            sharedPushEngine = [[SJPushEngine alloc] init];
        }
        
        return sharedPushEngine;
    }
}

- (id) init{
    if (self = [super init])
    {
    }
    return self;
}
- (void)pushWithAlert:(NSString*)alert
     andOtherTokenStr:(NSString*)sTokenStr
              andBody:(NSString*)sBody
{
    NSString *strURL;
    if (sBody && ![sBody isKindOfClass:[NSNull class]]) {
        strURL = [NSString stringWithFormat:@"http://www.nicelz.com/ljm/push1.php?deviceToken=%@&message=%@&body=%@",sTokenStr,alert,sBody];
    }
    else{
        strURL = [NSString stringWithFormat:@"http://www.nicelz.com/ljm/push.php?deviceToken=%@&message=%@",sTokenStr,alert];//@"http://www.nicelz.com/ljm/push.php?deviceToken=fd4a72f7ce3237dea41f1cea215ce0de9fbe249a475c0facf9adc8be1abdf07f&message=welcome";
    }
    strURL = [strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strURL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}
@end
