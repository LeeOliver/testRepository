//
//  NSClassEnhance.m
//  shijin
//
//  Created by apple on 13-7-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "NSClassEnhance.h"

@implementation NSMutableDictionary (Enhance)

- (void)assemblyValue:(id)value
                  key:(NSString*)sKey
             optional:(BOOL)bOptional
{
    if (value && ![value isKindOfClass:[NSNull class]] &&
        sKey && ![sKey isKindOfClass:[NSNull class]])
    {
        [self setValue:value forKey:sKey];
    }
    else
    {
        if (bOptional)
        {
            [self removeObjectForKey:sKey];
        }
        else
        {
            [self setValue:@"" forKey:sKey];
        }
    }
}


@end
@implementation NSDictionary (Enhance)

- (id)objectForKeyNotNull:(id)key
{
    id object = [self objectForKey:key];
    if (object == [NSNull null])
    {
        return nil;
    }
    else
    {
        return object;
    }
}


- (NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id oneValue = [self valueForKey:key];
        id oneCopy = nil;
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)])
        {
            oneCopy = [oneValue mutableDeepCopy];
        }
        else if ([oneValue respondsToSelector:@selector(mutableCopy)])
        {
            oneCopy = [oneValue mutableCopy];
        }
        if (oneCopy == nil) {
            oneCopy = [oneValue copy];
        }
        [ret setValue:oneCopy forKey:key];
    }
    return ret;
}
@end
@implementation UILabel (Enhance)
- (UILabel *)mutableDeepCopy
{
    UILabel *tmpLabel = [[UILabel alloc]initWithFrame:self.frame];
    tmpLabel.text = self.text;
    tmpLabel.textAlignment = self.textAlignment;
    tmpLabel.textColor = self.textColor;
    tmpLabel.tag = self.tag;
    tmpLabel.font = self.font;
    tmpLabel.backgroundColor = self.backgroundColor;
    return tmpLabel;
}
@end
