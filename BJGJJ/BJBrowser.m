//
//  BJBrowser.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/31.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "BJBrowser.h"

#import <UIImageView+AFNetworking.h>
#import <AFImageDownloader.h>
#import <AFNetworking.h>
#import "Encrypt.h"
#import "NSString+Converter.h"
#import "Browser.h"
#import "HtmlPraser.h"

#define kChoice @"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-choice.jsp"
#define kSecruityCode @"http://www.bjgjj.gov.cn/wsyw/servlet/PicCheckCode1"
#define kLoginUrl @"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp"
#define kLKUrl @"http://www.bjgjj.gov.cn/wsyw/wscx/asdwqnasmdnams.jsp"



@implementation BJBrowser{
    Browser *_browser;
    NSString * _cookie;
    NSString * _lk;
    HtmlPraser *_praser;
}



-(id)init{
    
    if (self = [super init]) {
        _browser = [[Browser alloc] initWithStringEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        _praser = [[HtmlPraser alloc] init];
    }
    
    return self;
}


-(void)loginWithCardNumber:(NSString *)number andPassword:(NSString *)password andSecurityCode:(NSString *)code status:(Response)statusList{
    Encrypt * enc = [[Encrypt alloc]init];
    
    // FormData
    NSString * encodeNumber = [enc strEncode:number];
    NSString * encodePassword = [enc strEncode:password];
    NSDictionary * paramaters = @{@"lb"             :@"5",
                                  @"bh"             : encodeNumber,
                                  @"mm"             : encodePassword,
                                  @"gjjcxjjmyhpppp" :code,
                                  @"lk"             :_lk
                                  };
    // 设置Headers
    NSDictionary * headers = @{
                               @"Host"                  :@"www.bjgjj.gov.cn",
                               @"Content-Type"          :@"application/x-www-form-urlencoded",
                               @"Connection"            :@"keep-alive",
                               @"User-Agent"            :@"Mozilla/5.0 (Windows;U; Windows NT 5.1; en-US; rv:0.9.4)",
                               @"Accept-Language"       :@"zh-CN",
                               @"Accept-Encoding"       :@"gzip, deflate",
                               @"Accept"                :@"*/*",
                               @"Cookie"                :_cookie
                               };
    
    [_browser POST:kChoice headers:headers formData:paramaters response:^(NSString *responseHtml) {
        NSLog(@"%@", responseHtml);
        
        [_praser praserStatusList:responseHtml];
    }];
}





- (void)refreshSecurityCode:(UIImageView *)vCodeImageView {
    AFImageDownloader *downloader = [[vCodeImageView class] sharedImageDownloader];
    id <AFImageRequestCache> imageCache = downloader.imageCache;
    [imageCache removeImageWithIdentifier:kSecruityCode];

    
    NSURL *URL = [NSURL URLWithString:kSecruityCode];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:_cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"image/webp,image/*,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"Mozilla/5.0 (Windows;U; Windows NT 5.1; en-US; rv:0.9.4)" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp" forHTTPHeaderField:@"Referer"];
    
    
    UIImageView * view = vCodeImageView;
    
    [vCodeImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [view setImage:image];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
}

- (void)refreshLK {
    [_browser POST:kLKUrl headers:nil formData:nil response:^(NSString *responseHtml) {
        
        NSString *trimmedString = [responseHtml stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString * lk = [trimmedString substringFromIndex:4];
        
        _lk = lk;
    }];
}

-(void)refreshVCodeToUIImageView:(UIImageView* ) vCodeImageView{
    
    NSDictionary * headers = @{
                               @"Host"                  :@"www.bjgjj.gov.cn",
                               @"Content-Type"          :@"application/x-www-form-urlencoded",
                               @"Connection"            :@"keep-alive",
                               @"User-Agent"            :@"Mozilla/5.0 (Windows;U; Windows NT 5.1; en-US; rv:0.9.4)",
                               @"Accept-Language"       :@"zh-CN",
                               @"Accept-Encoding"       :@"gzip, deflate",
                               @"Accept"                :@"*/*",
                               };
    
    [_browser GET:kLoginUrl headers:headers response:^(NSString *responseHtml) {
        
        NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        
        NSString *cookiesString = @"";
        
        for (NSHTTPCookie *cookie in cookies) {
            cookiesString = [cookiesString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value]];
        }
        
        _cookie = cookiesString;
        
        [self refreshLK];
        
        [self refreshSecurityCode:vCodeImageView];
        

        
    }];

}

@end
