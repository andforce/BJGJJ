//
// Created by 迪远 王 on 2017/10/21.
// Copyright (c) 2017 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CountInfoBean : NSObject

@property(nonatomic, strong) NSString* userName;        //姓名
@property(nonatomic, strong) NSString* cardType;        //证件类型
@property(nonatomic, strong) NSString* companyNumber;   //单位登记号
@property(nonatomic, strong) NSString* sectionNumber;   //所属管理部门编号
@property(nonatomic, strong) NSString* balance;         //当前余额
@property(nonatomic, strong) NSString* currentPayment;  //当年缴存金额
@property(nonatomic, strong) NSString* lastYearBalance; //上年结转金额
@property(nonatomic, strong) NSString* transCount;      //转出金额

@property(nonatomic, strong) NSString* personalNumber;  //个人登记号
@property(nonatomic, strong) NSString* cardNumber;      //证件号
@property(nonatomic, strong) NSString* companyName;     //单位名称
@property(nonatomic, strong) NSString* sectionName;     //所属管理部名称
@property(nonatomic, strong) NSString* status;          //账户状态
@property(nonatomic, strong) NSString* pickUpCount;     //当年提取金额
@property(nonatomic, strong) NSString* actionDate;      //最后业务日期


@end