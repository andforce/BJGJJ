//
//  CaptchaBrowser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CaptchaResult) (BOOL success, NSString* captchaText);

@interface CaptchaBrowser : NSObject

-(void) captchaToText:(UIImage*) captchaImage response:(CaptchaResult)response;

@end
