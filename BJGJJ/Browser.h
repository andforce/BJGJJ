//
//  Browser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Browser : NSObject

-(void) loginWithCardNumber:(NSString*) number andPassword:(NSString*)password andSecurityCode:(NSString*)code;

@end
