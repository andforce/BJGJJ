//
// Created by 迪远 王 on 2017/10/21.
// Copyright (c) 2017 andforce. All rights reserved.
//

#import "CountInfoBean.h"


@implementation CountInfoBean {

}
- (CountInfoBean *)demo {

    CountInfoBean * countInfoBean = [[CountInfoBean alloc] init];
    
    countInfoBean.userName          = @"王大锤";        //姓名
    countInfoBean.cardType          = @"身份证";        //证件类型
    countInfoBean.companyNumber     = @"141141";   //单位登记号
    countInfoBean.sectionNumber     = @"105";   //所属管理部门编号
    countInfoBean.balance           = @"12345.67元";         //当前余额
    countInfoBean.currentPayment    = @"345.00元";  //当年缴存金额
    countInfoBean.lastYearBalance   = @"1200.67元"; //上年结转金额
    countInfoBean.transCount        = @"0.00元";      //转出金额

    countInfoBean.personalNumber    = @"11028119990110562300";  //个人登记号
    countInfoBean.cardNumber        =@"110281199901105623";      //证件号
    countInfoBean.companyName       =@"我也不知道科技有限公司";     //单位名称
    countInfoBean.sectionName       =@"朝阳管理部";     //所属管理部名称
    countInfoBean.status            =@"缴存";          //账户状态
    countInfoBean.pickUpCount       =@"0.00元";     //当年提取金额
    countInfoBean.actionDate        =@"2017-09-30";      //最后业务日期

    countInfoBean.employeeNumber    =@"1256";    //员工编号
    
    return countInfoBean;
}

@end
