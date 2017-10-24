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

#define kUserAgent @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"

typedef void(^LKResponse) (BOOL isSuccess, NSString * lk);

@implementation BJBrowser{
    Browser *_browser;
    NSString * _lk;
    HTMLParser *_praser;
}



-(id)init{

    if (self = [super init]) {
        _browser = [[Browser alloc] initWithStringEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        _praser = [[HTMLParser alloc] init];
        _lk = @"";
    }

    return self;
}

- (void)loadNewCookie:(CookieResponse)response {
    [self clearCookie];

    [self loadCookieFromChoice:^(BOOL isSuccess, NSString *cookie) {
        if (isSuccess){
            [self loadCookieFromFavicon:^(BOOL sucess, NSString *cookieResponse) {
                response(YES, cookieResponse);
            }];
        } else {
            response(NO, cookie);
        }
    }];
}

- (void)loadCookieFromChoice:(CookieResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :kUserAgent,
            @"Upgrade-Insecure-Requests"    :@"1",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br"

    };

    [_browser GET:@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp" headers:headers response:^(NSString *responseHtml) {
        NSString *cookie = [self cookieString];
        if (cookie.length > 0){
            handler(YES,cookie);
        } else {
            handler(NO,@"服务繁忙-Err104");
        }
    }];
}

- (void)loadCookieFromFavicon:(CookieResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :kUserAgent,
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br"
    };

    [_browser GET:kFavicon headers:headers response:^(NSString *responseHtml) {

        NSString *cookie = [self cookieString];
        if (cookie.length > 0){
            handler(YES,cookie);
        } else {
            handler(NO,@"服务繁忙-Err105");
        }
    }];
}

-(NSDictionary *) formDataForIDCard:(NSString *)lk lb:(NSString *)lb cardNumber:(NSString *)number pwd:(NSString *)password code:(NSString *)code{
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
            @"lk"               :lk
    };
    return paramaters;
}

-(NSDictionary *) formDataForBankCard:(NSString *)lk lb:(NSString *)lb cardNumber:(NSString *)number pwd:(NSString *)password code:(NSString *)code{
    Encrypt * enc = [[Encrypt alloc]init];

    // FormData
    NSString * encodeNumber = [enc strEncode:number];
    NSString * encodePassword = [enc strEncode:password];

    NSDictionary * paramaters = @{
            @"lb"               :lb,
            @"bh"               : encodeNumber,
            @"mm"               : encodePassword,
            @"gjjcxjjmyhpppp"   :code,
            @"bh5"              :number,
            @"mm5"              :password,
            @"gjjcxjjmyhpppp5"  :code,
            @"bh2"              :@"",
            @"mm2"              :@"",
            @"gjjcxjjmyhpppp2"  :@"",
            @"mm1"              :@"",
            @"bh1"              :@"",
            @"gjjcxjjmyhpppp1"  :@"",
            @"bh3"              :@"",
            @"mm3"              :@"",
            @"gjjcxjjmyhpppp3"  :@"",
            @"bh4"              :@"",
            @"mm4"              :@"",
            @"gjjcxjjmyhpppp4"  :@"",
            @"lk"               :lk
    };
    return paramaters;
}


-(void)loginWithCard:(NSString*) lb number:(NSString *)number andPassword:(NSString *)password
     andSecurityCode:(NSString *)code status:(Response)statusList{

    // FormData
    NSDictionary * paramaters;
    if ([lb intValue] == 1){
        paramaters = [self formDataForIDCard:_lk lb:lb cardNumber:number pwd:password code:code];
    } else{
        paramaters = [self formDataForBankCard:_lk lb:lb cardNumber:number pwd:password code:code];
    }
    // 设置Headers

    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"Cache-Control"        :@"max-age=0",
            @"Origin"               :@"https://www.bjgjj.gov.cn",
            @"Upgrade-Insecure-Requests"    :@"1",
            @"Content-Type"          :@"application/x-www-form-urlencoded",
            @"User-Agent"            :kUserAgent,

            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",

            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };
    [_browser POST:kChoice headers:headers formData:paramaters response:^(NSString *responseHtml) {
        if (responseHtml){
            NSArray<StatusBean*>* status = [_praser parseStatusList:responseHtml];
            if (status.count > 0){
                statusList(YES, status);
            } else {
                statusList(NO, @"服务繁忙-Err100");
                NSLog(@"登录失败001\t\n%@", responseHtml.trim);
            }

        } else {
            NSLog(@"登录失败002\t\n%@", responseHtml.trim);
            statusList(NO, @"服务繁忙-Err101");
        }
    }];
}




- (void)refreshLK:(LKResponse) lkResponse {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"Origin"               :@"https://www.bjgjj.gov.cn",
            @"Content-Type"          :@"text/html;",
            @"User-Agent"            :kUserAgent,
            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp",
            @"Accept"                :@"*/*",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };
    [_browser POST:kLKUrl headers:headers formData:nil response:^(NSString *responseHtml) {

        NSString *trimmedString = [responseHtml stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSInteger len = trimmedString.length;
        NSString * lkFull = [trimmedString substringWithRange:NSMakeRange(len - 2, 2)];
        NSString *lk = [lkFull stringWithRegular:@"\\d+"];

        if (lk && lk.length > 0){
            lkResponse(YES, lk);
        } else {
            lkResponse(NO, @"");
        }
    }];
}

-(void) clearCookie{
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.domain containsString:@"bjgjj.gov.cn"]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

-(NSString *) cookieString{
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

    NSString *cookiesString = @"";

    int pos = 0;
    for (NSHTTPCookie *cookie in cookies) {
        if ([cookie.domain containsString:@"bjgjj.gov.cn"]){
            NSString * formater = @"%@=%@; ";
            if (pos == cookies.count - 1) {
                formater = @"%@=%@";
            }
            cookiesString = [cookiesString stringByAppendingString:[NSString stringWithFormat:formater, cookie.name, cookie.value]];
        }
        pos ++;
    }
    return cookiesString;
}

- (void)showCountInfo:(StatusBean *)statusBean handler:(DetailResponse)handler {
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"Upgrade-Insecure-Requests"    :@"1",
            @"User-Agent"            :kUserAgent,

            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-choice.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",

            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };

    //NSLog(@"detail url: %@ - cookie: %@", statusBean.companyLink, [self cookieString]);

    [_browser GET:statusBean.companyLink headers:headers response:^(NSString *responseHtml) {
        if (responseHtml){

            CountInfoBean * countInfoBean = [_praser parseCountInfoBean:responseHtml];
            if (countInfoBean){
                handler(YES, countInfoBean);
            } else {
                handler(NO, @"服务繁忙-Err102");
            }
        } else {
            handler(NO,@"服务繁忙-Err103");
        }
        
    }];
}

- (void)refreshLkAndVCode:(UIImageView *)showCapImageView :(CaptchaImage)captchaImage {
    
    [self refreshVCodeToUIImageView:showCapImageView :captchaImage];
    
    [self refreshLK:^(BOOL isSuccess, NSString *lk) {
        if (isSuccess){
            _lk = lk;
        } else {
            _lk = @"";
        }
    }];
}


-(void)refreshVCodeToUIImageView:(UIImageView *)showCapImageView :(CaptchaImage)captchaImage{
    NSDictionary * headers = @{
            @"Host"                  :@"www.bjgjj.gov.cn",
            @"Connection"            :@"keep-alive",
            @"User-Agent"            :kUserAgent,
            @"Referer"              :@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp",
            @"Accept"                :@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8",
            @"Accept-Language"       :@"zh-CN,zh;q=0.8,en;q=0.6",
            @"Accept-Encoding"       :@"gzip, deflate, br",
            @"Cookie"               :[self cookieString]

    };

    [_browser GET:kLoginUrl headers:headers response:^(NSString *responseHtml) {

        //[self refreshLK];

        AFImageDownloader *downloader = [[showCapImageView class] sharedImageDownloader];
        id <AFImageRequestCache> imageCache = downloader.imageCache;
        [imageCache removeImageWithIdentifier:kSecruityCode];


        NSURL *URL = [NSURL URLWithString:kSecruityCode];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        [request setValue:[self cookieString] forHTTPHeaderField:@"Cookie"];
        [request setValue:@"image/webp,image/*,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [request setValue:kUserAgent forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"https://www.bjgjj.gov.cn/wsyw/wscx/gjjcx-login.jsp" forHTTPHeaderField:@"Referer"];


        UIImageView * view = showCapImageView;

        [showCapImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {

            [view setImage:image];

            captchaImage(image);

        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {

        }];



    }];
}



@end
