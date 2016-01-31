//
//  CaptchaBrowser.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "CaptchaBrowser.h"
#import "Browser.h"
#import "NSString+Regular.h"
#import <IGHTMLQuery.h>

#define kOCROnLine @"http://lab.ocrking.com/#"

#define kApi @"http://lab.ocrking.com/ok.html"

#define kUpload @"http://lab.ocrking.com/upload.html"
#define kDoUrl @"http://lab.ocrking.com/do.html"

@implementation CaptchaBrowser{
    Browser *_browser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _browser = [[Browser alloc] initWithStringEncoding:NSUTF8StringEncoding];
    }
    return self;
}
-(void)captchaToText:(UIImage *)captchaImage response:(CaptchaResult)response{
    
    
    [_browser GET:kOCROnLine response:^(NSString *responseHtml) {
        NSString * sid = [responseHtml stringWithRegular:@"\"\\w{26}\""];
        NSString * o_h = [responseHtml stringWithRegular:@"\"\\S{56}\""];
        NSString * ts = [responseHtml stringWithRegular:@"\"\\d{10}\""];
        
        NSLog(@"captchaToText->  %@  %@   %@ ", sid, o_h, ts);
        
        NSDictionary * formData = @{
                                    @"Filename"    :@"123.jpeg",
                                    @"o_h"         :o_h,
                                    @"sid"         :sid,
                                    @"ts"          :ts,
                                    @"Upload"      :@"Submit Query"
                                    };
        
        [_browser POST:kUpload uploadImage:captchaImage serverAcceptFileName:@"Filedata" fileName:@"123.jpeg" headers:nil formData:formData response:^(NSString *responseHtml) {
            NSLog(@"----upload %@", responseHtml);
            
            NSString * fileID = [responseHtml stringWithRegular:@"\\w{40}"];
            
            if (fileID == nil) {
                [self captchaToTextAPI:captchaImage response:response];
            } else{
                NSDictionary * doFormData = @{
                                              @"service"            :@"OcrKingForCaptcha",
                                              @"language"           :@"eng",
                                              @"charset"            :@"4",
                                              @"upfile"             :@"true",
                                              @"fileID"             :fileID,
                                              @"email"              :@""
                                              };
                
                
                [_browser POST:kDoUrl headers:nil formData:doFormData response:^(NSString *responseHtml) {
                    
                    IGXMLDocument * xmlDoc = [[IGXMLDocument alloc] initWithXMLString:responseHtml error:nil];
                    
                    IGXMLNodeSet *set = [xmlDoc children];
                    IGXMLNode * resultList = set[0];
                    IGXMLNodeSet * resultSet = [resultList children];
                    
                    IGXMLNodeSet * tmpSet = [resultSet[0] children];
                    NSString * status;// = [tmpSet[1] text];
                    NSString * result;// = [tmpSet[0] text];
                    
                    for (IGXMLNode *node in tmpSet) {
                        if ([[node tag] isEqualToString:@"Status"]) {
                            status = [node text];
                        } else if([[node tag] isEqualToString:@"Result"]){
                            result = [node text];
                        }
                    }
                    
                    //<Result>亲，你访问有些快,再不减速小心被判定为恶意访问哦！</Result>
                    //response([status isEqualToString:@"true"], result);
                    if ([status isEqualToString:@"true"]) {
                        response(YES, result);
                    } else{
                        [self captchaToTextAPI:captchaImage response:response];
                    }
                    
                }];
            }
            
        }];
    }];
}

-(void)captchaToTextAPI:(UIImage *)captchaImage response:(CaptchaResult)response{
    NSDictionary * formData = @{
                                  @"service"            :@"OcrKingForCaptcha",
                                  @"language"           :@"eng",
                                  @"charset"            :@"4",
                                  @"upfile"             :@"true",
                                  @"apiKey"             :@"6f1778d580e8ef5888Tfr6gHNXq4dUK3j8R2o1QvKM81CLso5bSrKriarRJMAnetMxi86h",
                                  @"type"               :@"http://www.nopreprocess.com"
                                  };
    
    [_browser POST:kApi uploadImage:captchaImage serverAcceptFileName:@"ocrfile" fileName:@"123.jpeg" headers:nil formData:formData response:^(NSString *responseHtml) {
        NSLog(@"captchaToText->  %@ ", responseHtml);
        
        IGXMLDocument * xmlDoc = [[IGXMLDocument alloc] initWithXMLString:responseHtml error:nil];
        
        IGXMLNodeSet *set = [xmlDoc children];
        IGXMLNode * resultList = set[0];
        IGXMLNodeSet * resultSet = [resultList children];
        
        IGXMLNodeSet * tmpSet = [resultSet[0] children];
        NSString * status;// = [tmpSet[1] text];
        NSString * result;// = [tmpSet[0] text];
        
        for (IGXMLNode *node in tmpSet) {
            if ([[node tag] isEqualToString:@"Status"]) {
                status = [node text];
            } else if([[node tag] isEqualToString:@"Result"]){
                result = [node text];
            }
        }
        
        response([status isEqualToString:@"true"], result);
        
    }];
}

@end

