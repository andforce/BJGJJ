//
//  TransDataUIViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/2/2.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "TransDataUIViewController.h"

@interface TransDataUIViewController ()

@end

@implementation TransDataUIViewController

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)transData:(NSObject*)transdata{
    [self setValue:transdata forKey:@"data"];
}


@end
