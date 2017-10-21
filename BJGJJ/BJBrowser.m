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
#import "HTMLParser.h"
#import "NSString+Regular.h"
#import "CountInfoBean.h"

#define kChoice @"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-choice.jsp"
#define kSecruityCode @"https://www.bjgjj.gov.cn/wsyw/servlet/PicCheckCode1"
#define kLoginUrl @"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp"
#define kLKUrl @"https://www.bjgjj.gov.cn/wsyw/wscx/asdwqnasmdnams.jsp"

#define kFavicon @"https://www.bjgjj.gov.cn/favicon.ico"



@implementation BJBrowser{
    Browser *_browser;
    NSString * _cookie;
    NSString * _lk;
    HTMLParser *_praser;
}



-(id)init{

    if (self = [super init]) {
        _browser = [[Browser alloc] initWithStringEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        _praser = [[HTMLParser alloc] init];
    }

    return self;
}


- (void)loadCookieFromChoice:(CookieResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
            @"Upgrade-Insecure-Requests"    :@"1",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br"

    };

    [_browser GET:@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp" headers:headers response:^(NSString *responseHtml) {
        handler([self cookieString]);
        NSLog(@"choice cookie %@", [self cookieString]);
    }];
}

- (void)loadCookieFromFavicon:(NSString *)choiceCookie handler:(CookieResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br"
    };

    [_browser GET:kFavicon headers:headers response:^(NSString *responseHtml) {
        NSLog(@"Favicon cookie %@", [self cookieString]);
        handler([self cookieString]);
    }];
}

-(void)loginWithCard:(NSString*) lb number:(NSString *)number andPassword:(NSString *)password
     andSecurityCode:(NSString *)code status:(Response)statusList{

    Encrypt * enc = [[Encrypt alloc]init];

    // FormData
    NSString * encodeNumber = [enc strEncode:number];
    NSString * encodePassword = [enc strEncode:password];

    NSDictionary * paramaters = @{
            @"lb"               :lb,
            @"bh"               : encodeNumber,
            @"mm"               : encodePassword,
            @"gjjcxjjmyhpppp"   :code,
            @"bh5"              :@"",
            @"mm5"              :@"",
            @"gjjcxjjmyhpppp5"  :@"",
            @"bh2"              :@"",
            @"mm2"              :@"",
            @"gjjcxjjmyhpppp2"  :@"",
            @"mm1"              :password,
            @"bh1"              :number,
            @"gjjcxjjmyhpppp1"  :code,
            @"bh3"              :@"",
            @"mm3"              :@"",
            @"gjjcxjjmyhpppp3"  :@"",
            @"bh4"              :@"",
            @"mm4"              :@"",
            @"gjjcxjjmyhpppp4"  :@"",
            @"lk"               :_lk
    };
    // 设置Headers

    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"Cache-Control"        :@"max-age=0",
            @"Origin"               :@"https://www.bjgjj.gov.cn",
            @"Upgrade-Insecure-Requests"    :@"1",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"User-Agent"            :@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",

            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",

            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };
    [_browser POST:kChoice headers:headers formData:paramaters response:^(NSString *responseHtml) {
        NSLog(@"%@", responseHtml);
        statusList([_praser praserStatusList:responseHtml]);
    }];
}




- (void)refreshLK {
    [_browser POST:kLKUrl headers:nil formData:nil response:^(NSString *responseHtml) {

        NSString *trimmedString = [responseHtml stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSInteger len = trimmedString.length;
        NSString * lkFull = [trimmedString substringWithRange:NSMakeRange(len - 2, 2)];
        NSString *lk = [lkFull stringWithRegular:@"\\d+"];

        _lk = lk;
    }];
}

-(NSString *) cookieString{
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSString *cookiesString = @"";

    int pos = 0;
    for (NSHTTPCookie *cookie in cookies) {
        NSString * formater = @"%@=%@; ";
        if (pos == cookies.count - 1) {
            formater = @"%@=%@";
        }
        cookiesString = [cookiesString stringByAppendingString:[NSString stringWithFormat:formater, cookie.name, cookie.value]];
        pos ++;
    }
    return cookiesString;
}

- (void)showCountInfo:(StatusBean *)statusBean handler:(DetailResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"Upgrade-Insecure-Requests"    :@"1",
            @"User-Agent"            :@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",

            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-choice.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",

            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };

    NSLog(@"detail url: %@ - cookie: %@", statusBean.companyLink, [self cookieString]);

    [_browser GET:statusBean.companyLink headers:headers response:^(NSString *responseHtml) {
        NSLog(@"%@", responseHtml);
    }];
}

-(void)refreshVCodeToUIImageView:(UIImageView *)showCapImageView :(CaptchaImage)captchaImage{
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36",
            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };

    [_browser GET:kLoginUrl headers:headers response:^(NSString *responseHtml) {

        [self refreshLK];

        AFImageDownloader *downloader = [[showCapImageView class] sharedImageDownloader];
        id <AFImageRequestCache> imageCache = downloader.imageCache;
        [imageCache removeImageWithIdentifier:kSecruityCode];


        NSURL *URL = [NSURL URLWithString:kSecruityCode];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setValue:[self cookieString] forHTTPHeaderField:@"Cookie"];
        [request setValue:@"image/webp,image/*,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"http://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp" forHTTPHeaderField:@"Referer"];


        UIImageView * view = showCapImageView;

        [showCapImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {

            [view setImage:image];

            captchaImage(image);

        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {

        }];



    }];
}



@end
