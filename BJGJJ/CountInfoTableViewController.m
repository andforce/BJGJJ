//
//  CountInfoTableViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/2/2.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "CountInfoTableViewController.h"
#import "CountInfoBean.h"

@interface CountInfoTableViewController ()<TransBundleDelegate>{

    
    IBOutlet UILabel *blanceLb;
    IBOutlet UILabel *companyName;
    IBOutlet UILabel *sectionName;
    IBOutlet UILabel *status;
    
    IBOutlet UILabel *actionDate;
    IBOutlet UILabel *cardType;
    IBOutlet UILabel *cardNumber;
    IBOutlet UILabel *personalNumber;
    IBOutlet UILabel *companyNumber;
    IBOutlet UILabel *sectionNumber;
    IBOutlet UILabel *currentPayment;
    IBOutlet UILabel *pickUpCount;
    IBOutlet UILabel *lastYearBlance;
    IBOutlet UILabel *transCount;
    
    CountInfoBean *_countInfoBean;
}

@end

@implementation CountInfoTableViewController

- (void)transBundle:(TransBundle *)bundle {
    _countInfoBean = [bundle getObjectValue:@"count_info"];

    NSLog(@">>>>>>>>>>>> %@", _countInfoBean.balance);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    blanceLb.text = _countInfoBean.balance;

    companyName.text = _countInfoBean.companyName;
    sectionName.text = _countInfoBean.sectionName;
    status.text = _countInfoBean.status;

    actionDate.text = _countInfoBean.actionDate;
    cardType.text = _countInfoBean.cardType;
    cardNumber.text = _countInfoBean.cardNumber;
    personalNumber.text = _countInfoBean.personalNumber;
    companyNumber.text = _countInfoBean.companyNumber;
    sectionNumber.text = _countInfoBean.sectionNumber;
    currentPayment.text = _countInfoBean.currentPayment;
    pickUpCount.text = _countInfoBean.pickUpCount;
    lastYearBlance.text = _countInfoBean.lastYearBalance;
    transCount.text = _countInfoBean.transCount;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
