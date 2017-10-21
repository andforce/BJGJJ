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


typedef void(^Response) (NSArray<StatusBean*>* statusList);
typedef void(^CaptchaImage) (UIImage* captchaImage);
typedef void(^DetailResponse) (CountInfoBean * countInfoBean);

typedef void(^CookieResponse) (NSString * cookie);

@interface BJBrowser : NSObject

-(void) loadCookieFromChoice:(CookieResponse) handler;

-(void) loadCookieFromFavicon:(NSString *) choiceCookie handler:(CookieResponse) handler;

-(void) loginWithCard:(NSString*) lb number:(NSString *)number andPassword:(NSString *)password andSecurityCode:(NSString *)code status:(Response)statusList;

-(void) showCountInfo:(StatusBean *)statusBean handler:(DetailResponse) handler;

-(void)refreshVCodeToUIImageView:(UIImageView* )showCapImageView :(CaptchaImage)captchaImage;


@end
