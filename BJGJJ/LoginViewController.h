//
//  LoginViewController.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransBundleUIViewController.h"

@interface LoginViewController : TransBundleUIViewController
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *securityCode;
@property (weak, nonatomic) IBOutlet UITextField *code;

- (IBAction)refreshSecurityCode:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)changeCountType:(id)sender;

@end
