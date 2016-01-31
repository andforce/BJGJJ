//
//  Browser.m
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import "Browser.h"
#import <UIImageView+AFNetworking.h>
#import <AFImageDownloader.h>
#import <AFNetworking.h>
#import "Encrypt.h"
#import "NSString+Converter.h"

#define kChoice @"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-choice.jsp"
#define kSecruityCode @"http://www.bjgjj.gov.cn/wsyw/servlet/PicCheckCode1"
#define kLoginUrl @"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp"
#define kLKUrl @"http://www.bjgjj.gov.cn/wsyw/wscx/asdwqnasmdnams.jsp"


@implementation Browser{
    AFHTTPSessionManager *_browser;
    NSString * _cookie;
    NSString * _lk;
}

-(id)init{
    
    if (self = [super init]) {
        _browser = [AFHTTPSessionManager manager];
        _browser.requestSerializer.HTTPShouldHandleCookies = YES;
        _browser.responseSerializer = [AFHTTPResponseSerializer serializer];
        _browser.responseSerializer.acceptableContentTypes = [_browser.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    
    return self;
}




-(void)loginWithCardNumber:(NSString *)number andPassword:(NSString *)password andSecurityCode:(NSString *)code{
    

    Encrypt * enc = [[Encrypt alloc]init];
    
    NSString * encodeNumber = [enc strEncode:number];
    
    NSString * encodePassword = [enc strEncode:password];

    

    
    NSDictionary * paramaters = @{@"lb":@"5",
                         @"bh": encodeNumber,
                         @"mm": encodePassword,
                         @"gjjcxjjmyhpppp":code,
                         @"lk":_lk
                         };
    // 设置Headers
    [_browser.requestSerializer setValue:@"www.bjgjj.gov.cn" forHTTPHeaderField:@"Host"];
    [_browser.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [_browser.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [_browser.requestSerializer setValue:@"Mozilla/5.0 (Windows;U; Windows NT 5.1; en-US; rv:0.9.4)" forHTTPHeaderField:@"User-Agent"];
    [_browser.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [_browser.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    
    [_browser.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    
    [_browser.requestSerializer setValue:_cookie forHTTPHeaderField:@"Cookie"];
    
    
    
    [_browser POST:kChoice parameters:paramaters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:gbkEncoding] replaceUnicode];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        
    }];
    
}




-(void)refreshVCodeToUIImageView:(UIImageView* ) vCodeImageView{
    

    
    [_browser.requestSerializer setValue:@"www.bjgjj.gov.cn" forHTTPHeaderField:@"Host"];
    
    [_browser.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    
    [_browser.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
    [_browser.requestSerializer setValue:@"Mozilla/5.0 (Windows;U; Windows NT 5.1; en-US; rv:0.9.4)" forHTTPHeaderField:@"User-Agent"];
    
    [_browser.requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    
    [_browser.requestSerializer setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];

    
    [_browser GET:kLoginUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        
        NSString *cookiesString = @"";
        
        for (NSHTTPCookie *cookie in cookies) {
            cookiesString = [cookiesString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", cookie.name, cookie.value]];
        }
        
        NSLog(@"==========>>>>> %@", cookiesString);
        
        _cookie = cookiesString;
        
        
        
        [_browser POST:kLKUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *html = [[[NSString alloc] initWithData:responseObject encoding:gbkEncoding] replaceUnicode];
            
            NSString *trimmedString = [html stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            NSString * lk = [trimmedString substringFromIndex:4];
            
            _lk = lk;
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"------->>>-------------  ");
            
        }];

        
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
            
            NSLog(@"refreshDoor failed");
        }];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}
@end
