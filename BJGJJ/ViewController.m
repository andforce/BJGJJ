//
//  ViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "ViewController.h"
#import "Encrypt.h"
#import "NSArray+Converter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Encrypt * arr = [[Encrypt alloc] init];
    
    NSString * result = [arr strEncode:@"" firstKey:@"pdcss123" secondKey:@"css11q1a" thirdKey:@"co1qacq11"];
    
    int a[2] = {100,0};

    int lenA = sizeof(a) /sizeof(a[0]);
    
    NSArray * array = [NSArray arrayWithIntArray:a andIntArrayLength:lenA];
    
    NSLog(@"%@", array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
