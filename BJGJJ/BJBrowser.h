//
//  BJBrowser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StatusBean.h"

@class CountInfoBean;


typedef void(^Response) (BOOL isSuccess,NSArray<StatusBean*>* statusList);
typedef void(^CaptchaImage) (UIImage* captchaImage);
typedef void(^DetailResponse) (BOOL isSuccess,CountInfoBean * countInfoBean);

typedef void(^CookieResponse) (BOOL isSuccess, NSString * cookie);

@interface BJBrowser : NSObject

-(void) loadNewCookie:(CookieResponse) response;

-(void) loginWithCard:(NSString*) lb number:(NSString *)number andPassword:(NSString *)password andSecurityCode:(NSString *)code status:(Response)statusList;

-(void) showCountInfo:(StatusBean *)statusBean handler:(DetailResponse) handler;

-(void)refreshVCodeToUIImageView:(UIImageView* )showCapImageView :(CaptchaImage)captchaImage;


@end
