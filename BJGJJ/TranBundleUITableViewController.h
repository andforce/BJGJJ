//
// Created by WDY on 2016/11/7.
// Copyright (c) 2016 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TransBundle.h"
#import "TransBundleDelegate.h"

@interface TranBundleUITableViewController : UITableViewController
@property(nonatomic, strong) id <TransBundleDelegate> delegate;

@property(nonatomic, strong) TransBundle *bundle;

- (void)presentViewController:(UIViewController *)viewControllerToPresent withBundle:(TransBundle *)bundle forRootController:(BOOL)forRootController animated:(BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)dismissViewControllerAnimated:(BOOL)flag backToViewController:(UIViewController *)controller withBundle:(TransBundle *)bundle completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)transBundle:(TransBundle *)bundle forController:(UIViewController *)controller;

@end