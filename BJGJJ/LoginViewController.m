//
//  LoginViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "LoginViewController.h"
#import "Browser.h"



@interface LoginViewController (){
    
    Browser * _browser;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _browser = [[Browser alloc] init];

}


- (IBAction)refreshSecurityCode:(id)sender {
    [_browser refreshVCodeToUIImageView:_securityCode];
}

- (IBAction)login:(id)sender {
    [_browser loginWithCardNumber:_cardNumber.text andPassword:_password.text andSecurityCode:_code.text];
}
@end
