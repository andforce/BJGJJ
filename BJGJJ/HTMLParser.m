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

@implementation HTMLParser



-(NSArray<StatusBean *> *)praserStatusList:(NSString *)html{
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
