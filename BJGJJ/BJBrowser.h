//
//  BJBrowser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface BJBrowser : NSObject

-(void) loginWithCardNumber:(NSString*) number andPassword:(NSString*)password andSecurityCode:(NSString*)code;

-(void)refreshVCodeToUIImageView:(UIImageView* ) vCodeImageView;


@end
