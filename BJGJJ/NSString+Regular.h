//
//  NSString+Regular.h
//  CCF
//
//  Created by WDY on 16/1/11.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Regular)

-(NSString*) stringWithRegular:(NSString *) regular;

-(NSString*) stringWithRegular:(NSString *) regular andChild:(NSString *) childRegular;

-(NSString*) trim;

@end
