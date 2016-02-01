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

#define kLBValue @"lb"
#define kLBName @"lbName"


@interface LoginViewController (){
    
    BJBrowser * _browser;
    NSMutableDictionary *_lbList;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"lb" ofType:@"plist"];
    _lbList = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
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
    
    NSString * defaultName = [[NSUserDefaults standardUserDefaults] valueForKey:kLBName];
    if (defaultName == nil) {
        _cardNumber.placeholder = @"身份证";
    }
    
    
    

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
    NSString * lb = [[NSUserDefaults standardUserDefaults] valueForKey:kLBValue];
    if (lb == nil) {
        lb = @"1";
    }
    [_browser loginWithCard:lb number:_cardNumber.text andPassword:_password.text andSecurityCode:_code.text status:^(NSArray<StatusBean *> *statusList) {
       
   }];
}

- (IBAction)changeCountType:(id)sender {
    UIAlertController * insertPhotoController = [UIAlertController alertControllerWithTitle:@"切换登录方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray* keys = _lbList.allKeys;
    for (NSString* key  in keys) {
        NSString * name = [_lbList valueForKey:key];
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
            [def setValue:key forKey:kLBName];
            [def setValue:name forKey:kLBName];
            
            _cardNumber.placeholder = name;
        }];
        [insertPhotoController addAction:action];
    }
    
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [insertPhotoController addAction:cancel];
    
    [self presentViewController:insertPhotoController animated:YES completion:nil];
}
@end
