//
// Created by WDY on 2016/11/7.
// Copyright (c) 2016 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TransBundle.h"
#import "TransBundleDelegate.h"

@interface TransBundleUIViewController : UIViewController
@property(nonatomic, strong) id <TransBundleDelegate> transDelegate;

@property(nonatomic, strong) TransBundle *bundle;

- (void)presentViewController:(UIViewController *)viewControllerToPresent withBundle:(TransBundle *)bundle forRootController:(BOOL)forRootController animated:(BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)dismissViewControllerAnimated:(BOOL)flag backToViewController:(UIViewController *_Nullable)controller withBundle:(TransBundle *_Nullable)bundle completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);

- (void)transBundle:(TransBundle *_Nonnull)bundle forController:(UIViewController *_Nullable)controller;

@end
