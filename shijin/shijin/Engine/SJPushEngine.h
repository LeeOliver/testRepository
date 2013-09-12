//
//  SJPushEngine.h
//  shijin
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJPushEngine : NSObject
{
    NSString                        *_tokenStr;

}
@property (strong, nonatomic) NSString                        *tokenStr;

+ (SJPushEngine *)shareInstance;
- (id)init;

- (void)pushWithAlert:(NSString*)alert
     andOtherTokenStr:(NSString*)sTokenStr
              andBody:(NSString*)sBody;
@end
