//
//  HTMLParser.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "HTMLParser.h"
#import <IGHTMLQuery.h>
#import "NSString+Regular.h"
#import "CountInfoBean.h"

@implementation HTMLParser
- (CountInfoBean *)parseCountInfoBean:(NSString *)html {
    CountInfoBean *countInfoBean = [[CountInfoBean alloc] init];

    NSString * fixedHtml = [html.trim stringByReplacingOccurrencesOfString:@"charset=GBK" withString:@"charset=utf-8"];
    IGHTMLDocument *document = [[IGHTMLDocument alloc]initWithHTMLString:fixedHtml error:nil];

    countInfoBean.userName =        [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[1]/td[2]"];        //姓名
    countInfoBean.cardType=         [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[2]/td[2]"];        //证件类型
    countInfoBean.companyNumber=    [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[3]/td[2]"];   //单位登记号
    countInfoBean.sectionNumber=    [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[4]/td[2]"];   //所属管理部门编号
    countInfoBean.balance=          [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[5]/td[2]"];         //当前余额
    countInfoBean.currentPayment=   [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[6]/td[2]"];  //当年缴存金额
    countInfoBean.lastYearBalance=  [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[7]/td[2]"]; //上年结转金额
    countInfoBean.transCount=       [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[8]/td[2]"];      //转出金额

    countInfoBean.personalNumber =  [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[1]/td[4]"];  //个人登记号
    countInfoBean.cardNumber=       [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[2]/td[4]"];      //证件号
    countInfoBean.companyName=      [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[3]/td[4]"];     //单位名称
    countInfoBean.sectionName=      [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[4]/td[4]"];     //所属管理部名称
    countInfoBean.status=           [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[5]/td[4]"];          //账户状态
    countInfoBean.pickUpCount=      [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[6]/td[4]"];     //当年提取金额
    countInfoBean.actionDate=       [self cleanCountInfo:document xPath:@"//*[@id=\"t1Contents\"]/div[2]/table/tr[7]/td[4]"];      //最后业务日期

    countInfoBean.employeeNumber=   [self cleanCountInfo:document xPath:@"//*[@id=\"t2Contents\"]/div/table/tr/td/div/table/tr[2]/td[2]/table/tr[3]/td[2]"];
    
    
    return countInfoBean;
}

-(NSString *)cleanCountInfo:(IGHTMLDocument *)document11 xPath:(NSString *)path{
    NSString * html = [document11 queryWithXPath:path].firstObject.text.trim;
    return [[html stringByReplacingOccurrencesOfString:@"\r\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
}


-(NSArray<StatusBean *> *)parseStatusList:(NSString *)html{
    NSString * path = @"/html/body/table[2]/tr[3]/td/table/tr/td/div/table/tr[2]/td/div/table/tr[position()>=2]";
    IGHTMLDocument *document = [[IGHTMLDocument alloc]initWithHTMLString:html error:nil];
    IGXMLNodeSet* contents = [document queryWithXPath: path];
    
    NSMutableArray<StatusBean*> * status = [NSMutableArray array];
    
    for (IGXMLNode * node in contents) {
        
        StatusBean * bean = [[StatusBean alloc] init];
        IGXMLNodeSet * set = [node children];
        
        NSString * signedId = [set[0] text];
        NSString * companyName = [set[1] text];
        NSString * allText = [set[1] html];
        NSString * baseUrl = @"https://www.bjgjj.gov.cn/wsyw/wscx/";
        NSString * companyLink = [baseUrl stringByAppendingString:[allText stringWithRegular:@"gjj_cx.jsp(.*)lx=0"]];
        companyLink = [companyLink stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];


        NSString * statusInCompany = [set[2] text];
        
        bean.signedId = signedId;
        bean.companyName = companyName;
        bean.companyLink = companyLink;
        bean.status = statusInCompany;
        
        NSLog(@"~~~~~~~~~ %@  %@   %@   %@", signedId, companyName, companyLink, status);
        
        [status addObject:bean];
        
    }
    return status;
}
@end
