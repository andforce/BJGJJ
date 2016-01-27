//
//  Browser.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "Browser.h"

#import <AFNetworking.h>

#define kLoginUrl @"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp"
#define kSecruityCode @"http://www.bjgjj.gov.cn/wsyw/servlet/PicCheckCode1"


@implementation Browser{
    AFHTTPSessionManager *_browser;
}

-(id)init{
    
    if (self = [super init]) {
        _browser = [AFHTTPSessionManager manager];
        _browser.responseSerializer = [AFHTTPResponseSerializer serializer];
        _browser.responseSerializer.acceptableContentTypes = [_browser.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    return self;
}

-(void)loginWithCardNumber:(NSString *)number andPassword:(NSString *)password andSecurityCode:(NSString *)code{
    
}
@end
