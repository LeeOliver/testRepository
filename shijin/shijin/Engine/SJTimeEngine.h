//
//  SJTimeEngine.h
//  shijin
//
//  Created by apple on 13-8-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJTimeEngine : NSObject
{
    NSTimer *_iTime;//定时器
    int     _kCountTime;//计时变量
    id      _aDelegate;
    SEL     _aSel;
}

+ (SJTimeEngine *)shareInstance;
- (id)init;

///停止計時器
- (void)stopTimer;

/**
 *	@brief	循环每秒掉调用方法
 */
- (void)loopTimerByTime:(NSString*)aTime delegate:(id)aDelegate sel:(SEL)aSel;

@end
