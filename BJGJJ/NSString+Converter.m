//
//  NSString+Converter.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/30.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "NSString+Converter.h"

@implementation NSString(Converter)


+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

+ (NSString *)toHexhexaDecimalWithBinarySystem:(NSString *)binary{
    int temp = [[self toDecimalSystemWithBinarySystem:binary] intValue];
    
    NSString *str = [ [NSString alloc] initWithFormat:@"%X",temp];
    
    return str;
}

-(NSString *)replaceUnicode{
    
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:nil error:nil];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
    
}

@end
