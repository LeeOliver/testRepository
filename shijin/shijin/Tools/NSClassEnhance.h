//
//  NSClassEnhance.h
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
//#ifdef DEBUG
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
#   define DLog(...)
//#endif

// ALog always displays output regardless of the DEBUG setting
//#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ALog(fmt, ...)
// ALog always displays output regardless of the DEBUG setting
//#define BLog(fmt, ...) NSLog((@"Bunny---->%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define BLog(fmt, ...)

@interface NSMutableDictionary (Enhance)
- (void)assemblyValue:(id)value
                  key:(NSString*)sKey
             optional:(BOOL)bOptional;

@end
@interface NSDictionary (Enhance)
- (NSMutableDictionary *)mutableDeepCopy;
- (id)objectForKeyNotNull:(id)key;
@end
@interface UILabel (Enhance)
- (UILabel *)mutableDeepCopy;
@end
