//
//  TransBundleDelegate.h
//
//  Created by 迪远 王 on 16/4/24.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransBundle.h"

@protocol TransBundleDelegate <NSObject>


@required
- (void)transBundle:(TransBundle *)bundle;

@end
