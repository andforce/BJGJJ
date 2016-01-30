//
//  NSArray+Converter.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/30.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "NSArray+Converter.h"

@implementation NSArray(Converter)


+(instancetype)arrayWithIntArray:(int [])intArray andIntArrayLength:(int)length{
    NSMutableArray<NSNumber *> *numbers = [NSMutableArray arrayWithCapacity:length];
    for (int i = 0; i < length; i++) {
        NSNumber * number = [NSNumber numberWithInt:intArray[i]];
        [numbers addObject:number];
    }
    return [numbers copy];
}

@end
