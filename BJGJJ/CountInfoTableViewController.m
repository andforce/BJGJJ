//
//  CountInfoTableViewController.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/2/2.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "CountInfoTableViewController.h"
#import "CountInfoBean.h"
#import "UIColor+MyColor.h"

#define kHEIGHT 0

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
    
    IBOutlet UILabel *employeeNumber;
    IBOutlet UIView *headerView;
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

    self.tableView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);

    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(0, -kHEIGHT, [UIScreen mainScreen].bounds.size.width, kHEIGHT)];

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = headerView.backgroundColor;
    imageView.tag = 101;
    imageView.clipsToBounds = YES;

    [self.tableView addSubview:imageView];

    blanceLb.text = [_countInfoBean.balance substringWithRange:NSMakeRange(0, _countInfoBean.balance.length -1)];

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
    
    employeeNumber.text = _countInfoBean.employeeNumber ? _countInfoBean.employeeNumber : @"暂无";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -kHEIGHT) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
