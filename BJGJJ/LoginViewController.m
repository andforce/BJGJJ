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
#import "UIStoryboard+Forum.h"
#import "CountInfoBean.h"

#define kLBValue @"lb"
#define kLBName @"lbName"

#define kCardNumber @"cardnumber"
#define kCardPassward @"cardPwd"


@interface LoginViewController ()<TransBundleDelegate>{
    
    BJBrowser * _browser;
    NSMutableDictionary *_lbList;
    IBOutlet UILabel *loginType;
}

@end

@implementation LoginViewController

- (void)transBundle:(TransBundle *)bundle {

}


- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"lb" ofType:@"plist"];
    _lbList = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    _browser = [[BJBrowser alloc] init];

    [_browser loadNewCookie:^(BOOL isSuccess, NSString *cookie) {
        if (isSuccess){
            [self refreshVCode];
        }
    }];


    NSString *lb = [self readLoginType];

    // 获取已经登录过的
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    NSString * number = [pref valueForKey:[kCardNumber stringByAppendingString:lb]];
    NSString * password = [pref valueForKey:[kCardPassward stringByAppendingString:lb]];
    if (number != nil) {
        _cardNumber.text = number;
    }
    if (password != nil) {
        _password.text = password;
    }
    // 更新Placeholer
    if ([lb isEqualToString:@"1"]){
        _cardNumber.placeholder = @"身份证号码";
    } else {
        _cardNumber.placeholder = @"联名卡号码";
    }
}

- (void) showLoginType:(NSString *) lb{
    if ([lb isEqualToString:@"1"]){
        loginType.text = @"使用身份证查询";
    } else if ([lb isEqualToString:@"5"]){
        loginType.text = @"使用联名卡查询";
    } else {
        loginType.text = @"使用身份证查询";
    }
}

-(NSString *)readLoginType{
    NSString * lb = [[NSUserDefaults standardUserDefaults] valueForKey:kLBValue];
    if (lb == nil) {
        lb = @"1";
    }
    return lb;
}

- (void) refreshVCode{
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
    [self refreshVCode];
}

- (IBAction)login:(id)sender {

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSString * lb = [self readLoginType];
    NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
    [pref setValue:_cardNumber.text forKey:[kCardNumber stringByAppendingString:lb]];
    [pref setValue:_password.text forKey:[kCardPassward stringByAppendingString:lb]];
    
    [_browser loginWithCard:lb number:_cardNumber.text andPassword:_password.text andSecurityCode:_code.text
                     status:^(NSArray<StatusBean *> *statusList) {

                         [SVProgressHUD dismiss];

                         if (statusList && statusList.count > 0) {

                             StatusBean *statusBean = statusList.lastObject;
                             [_browser showCountInfo:statusBean handler:^(CountInfoBean *countInfoBean) {

                                 if (countInfoBean){
                                     TransBundle *transBundle = [[TransBundle alloc] init];
                                     [transBundle putObjectValue:countInfoBean forKey:@"count_info"];
                                     [transBundle putStringValue:countInfoBean.balance forKey:@"count_info_blance"];

                                     UIStoryboard *stortboard = [UIStoryboard mainStoryboard];
                                     CCFNavigationController *navigationController1 = [stortboard instantiateViewControllerWithIdentifier:@"CountDetailNaviController"];

                                     //CountInfoTableViewController *countInfoTableViewController = [stortboard instantiateViewControllerWithIdentifier:@"CountInfoTableViewController"];
                                     [navigationController1 transBundle:transBundle forController:navigationController1.viewControllers.firstObject];
                                     [stortboard changeRootViewControllerToController:navigationController1];
                                 }

                             }];
                         } else {


                         }

       
   }];
}

- (IBAction)changeCountType:(id)sender {
    UIAlertController * insertPhotoController = [UIAlertController alertControllerWithTitle:@"切换登录方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSArray* keys = _lbList.allKeys;
    for (NSString* key  in keys) {
        NSString * name = [_lbList valueForKey:key];
        UIAlertAction *action = [UIAlertAction actionWithTitle:name style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {


            NSUserDefaults * pref = [NSUserDefaults standardUserDefaults];
            [pref setValue:key forKey:kLBValue];
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

            //
            [self showLoginType:key];
            
        }];
        [insertPhotoController addAction:action];
    }
    
    
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [insertPhotoController addAction:cancel];
    
    [self presentViewController:insertPhotoController animated:YES completion:nil];
}
@end
