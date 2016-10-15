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
#import "CCFNavigationController.h"
#import "CountInfoViewController.h"

#define kLBValue @"lb"
#define kLBName @"lbName"

#define kCardNumber @"cardnumber"
#define kCardPassward @"cardPwd"


@interface LoginViewController (){
    
    BJBrowser * _browser;
    NSMutableDictionary *_lbList;
    
    
}

@property(nonatomic, strong) GADInterstitial *interstitial;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    if (true) {
        self.adView.adUnitID = @"ca-app-pub-4825035857684521/7836686290";
        
        //self.adView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
        
        self.adView.rootViewController = self;
        
        GADRequest *request = [GADRequest request];
        // Requests test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made. GADBannerView automatically returns test ads when running on a
        // simulator.
        request.testDevices = @[
                                @"2ed19fd608c97b865be80811f226e03a"  // Eric's iPod Touch
                                ];
        
        [self.adView loadRequest:request];
    }
    
    if (true) {
        
        self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-4825035857684521/7836686290"];
        
        GADRequest *request = [GADRequest request];
        // Requests test ads on test devices.
        request.testDevices = @[@"2ed19fd608c97b865be80811f226e03a"];
        [self.interstitial loadRequest:request];
        

    }

    
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
    
    
    NSString * lb = [[NSUserDefaults standardUserDefaults] valueForKey:kLBValue];
    if (lb == nil) {
        lb = @"1";
    }
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    NSString * number = [pref valueForKey:[kCardNumber stringByAppendingString:lb]];
    NSString * password = [pref valueForKey:[kCardPassward stringByAppendingString:lb]];
    if (number != nil) {
        _cardNumber.text = number;
    }
    if (password != nil) {
        _password.text = password;
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
    
    
    if (true) {
        if ([self.interstitial isReady]) {
            [self.interstitial presentFromRootViewController:self];
        }
        return;
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString * lb = [[NSUserDefaults standardUserDefaults] valueForKey:kLBValue];
    if (lb == nil) {
        lb = @"1";
    }
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    [pref setValue:_cardNumber.text forKey:[kCardNumber stringByAppendingString:lb]];
    [pref setValue:_password.text forKey:[kCardPassward stringByAppendingString:lb]];
    
    [_browser loginWithCard:lb number:_cardNumber.text andPassword:_password.text andSecurityCode:_code.text status:^(NSArray<StatusBean *> *statusList) {
        
        [SVProgressHUD dismiss];
        
        CCFNavigationController * root = (CCFNavigationController*)self.navigationController;
        
        UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CountInfoViewController * infoController = [storyboard instantiateViewControllerWithIdentifier:@"CountInfoViewController"];
        [infoController transData:statusList];
        
        [root setRootViewController:infoController];
       
   }];
}

- (IBAction)changeCountType:(id)sender {
    UIAlertController * insertPhotoController = [UIAlertController alertControllerWithTitle:@"切换登录方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray* keys = _lbList.allKeys;
    for (NSString* key  in keys) {
        NSString * name = [_lbList valueForKey:key];
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
            [pref setValue:key forKey:kLBName];
            [pref setValue:name forKey:kLBName];
            
            _cardNumber.placeholder = name;
            
            NSString * number = [pref valueForKey:[kCardNumber stringByAppendingString:key]];
            NSString * password = [pref valueForKey:[kCardPassward stringByAppendingString:key]];
            if (number != nil) {
                _cardNumber.text = number;
            }
            if (password != nil) {
                _password.text = password;
            }
            
        }];
        [insertPhotoController addAction:action];
    }
    
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [insertPhotoController addAction:cancel];
    
    [self presentViewController:insertPhotoController animated:YES completion:nil];
}
@end
