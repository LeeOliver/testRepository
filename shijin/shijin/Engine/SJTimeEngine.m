//
//  SJTimeEngine.m
//  shijin
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SJTimeEngine.h"

@implementation SJTimeEngine
static SJTimeEngine * sharedTimeEngine = NULL;
+(SJTimeEngine *)shareInstance{
    @synchronized(self){
        if(sharedTimeEngine == NULL){
            sharedTimeEngine = [[SJTimeEngine alloc] init];
        }
        
        return sharedTimeEngine;
    }
}

- (id) init{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)loopTimerByTime:(NSString*)aTime delegate:(id)aDelegate sel:(SEL)aSel;
{
    _kCountTime = 0;
    _aDelegate = aDelegate;
    _aSel = aSel;
    _iTime = [NSTimer scheduledTimerWithTimeInterval:[aTime doubleValue] target:self selector:@selector(getRequestStateTime:) userInfo:nil repeats:YES];//*//300

}
- (void)getRequestStateTime:(NSTimer *)timer
{
    if (_aDelegate &&
        [_aDelegate respondsToSelector:_aSel])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_aDelegate performSelector:_aSel];
#pragma clang diagnostic pop

    }
}

///停止計時器
- (void)stopTimer
{
    _kCountTime = 0;
    if([_iTime isValid])
        [_iTime invalidate];
    if(_aDelegate){
        _aDelegate = nil;
    }
    if (_aSel) {
        _aSel = nil;
    }
}

@end
