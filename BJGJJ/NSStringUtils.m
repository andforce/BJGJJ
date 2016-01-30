//
//  NSStringUtils.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/30.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "NSStringUtils.h"

@implementation NSStringUtils

+(BOOL)isEmpty:(NSString *)string{
    if (string == nil || [string isEqualToString:string]) {
        return YES;
    }
    return NO;
}
@end
