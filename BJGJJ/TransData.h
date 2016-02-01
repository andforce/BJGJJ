//
//  TransDataDelegate.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/2/2.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TransDataDelegate <NSObject>

@required
-(void) transData:(id) data;

@end

@interface TransData : NSObject

@property(nonatomic, strong) id data;
@end
