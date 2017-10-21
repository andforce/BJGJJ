//
//  HTMLParser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusBean.h"

@interface HTMLParser : NSObject

-(NSArray<StatusBean*>*) praserStatusList:(NSString*)html;


@end
