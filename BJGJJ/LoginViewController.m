//
//  LoginViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "LoginViewController.h"
#import "BJBrowser.h"
#import "CaptchaBrowser.h"
#import <SVProgressHUD.h>


@interface LoginViewController (){
    
    BJBrowser * _browser;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _browser = [[BJBrowser alloc] init];
    
    [_browser refreshVCodeToUIImageView:_securityCode :^(UIImage *captchaImage) {
        
        CaptchaBrowser * captcha = [[CaptchaBrowser alloc] init];
        [captcha captchaToText:captchaImage response:^(BOOL success, NSString *captchaText) {
            NSLog(@" 验证码 解析结果： %@     %@", success ? @"YES" : @"NO", captchaText);
            if (success) {
                _code.text = captchaText;
            }
        }];
    }];
    
    
    
    
    

}


- (IBAction)refreshSecurityCode:(id)sender {
    [_browser refreshVCodeToUIImageView:_securityCode :^(UIImage *captchaImage) {
        CaptchaBrowser * captcha = [[CaptchaBrowser alloc] init];
        [captcha captchaToText:captchaImage response:^(BOOL success, NSString *captchaText) {
            NSLog(@" 验证码 解析结果： %@     %@", success ? @"YES" : @"NO", captchaText);
            if (success) {
                _code.text = captchaText;
            }
        }];
    }];
}

- (IBAction)login:(id)sender {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
   [_browser loginWithCardNumber:_cardNumber.text andPassword:_password.text andSecurityCode:_code.text status:^(NSArray<StatusBean *> *statusList) {
       
   }];
}
@end
