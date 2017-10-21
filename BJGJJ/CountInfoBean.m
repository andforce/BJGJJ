//
// Created by 迪远 王 on 2017/10/21.
// Copyright (c) 2017 andforce. All rights reserved.
//

#import "CountInfoBean.h"


@implementation CountInfoBean {

}

-(id)copyWithZone:(NSZone *)zone{
    
    CountInfoBean * copy = [[CountInfoBean alloc] init];

    copy.userName = self.userName;
    copy.cardType= self.cardType;
    copy.companyNumber= self.companyNumber;
    copy.sectionNumber= self.sectionNumber;
    copy.balance= [NSString stringWithString:@"555"];
    copy.currentPayment= self.currentPayment;
    copy.lastYearBalance= self.lastYearBalance;
    copy.transCount= self.transCount;

    copy.personalNumber= self.personalNumber;
    copy.cardNumber= self.cardNumber;
    copy.companyName= self.companyName;
    copy.sectionName= self.sectionName;
    copy.status= self.status;
    copy.pickUpCount= self.pickUpCount;
    copy.actionDate= self.actionDate;
    
    return copy;
}
@end
