//
//  Encrypt.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/26.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encrypt : NSObject

-(NSString*) strEncode:(NSString*) data firstKey:(NSString*)key secondKey:(NSString*)key thirdKey:(NSString*)key;
@end
