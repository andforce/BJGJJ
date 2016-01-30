//
//  NSString+Converter.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/30.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Converter)

+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

+ (NSString *)toHexhexaDecimalWithBinarySystem:(NSString *)binary;

-(NSString *)replaceUnicode;
@end
