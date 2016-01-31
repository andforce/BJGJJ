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



@implementation Browser{
    AFHTTPSessionManager *_browser;
    NSString * _cookie;
    NSString * _lk;
    NSStringEncoding _encoding;
}


-(instancetype)initWithStringEncoding:(NSStringEncoding)encoding{
    
    if (self = [super init]) {
        _browser = [AFHTTPSessionManager manager];
        _browser.requestSerializer.HTTPShouldHandleCookies = YES;
        _browser.responseSerializer = [AFHTTPResponseSerializer serializer];
        _browser.responseSerializer.acceptableContentTypes = [_browser.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        _encoding = encoding;
    }
    return self;
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




#pragma mark GET
-(void)GET:(NSString *)url response:(responseHtml)response{
    [_browser GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)GET:(NSString *)url params:(NSDictionary *)params response:(responseHtml)response{
    
    [_browser GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)GET:(NSString *)url headers:(NSDictionary *)headers response:(responseHtml)response{
    
    if (headers != nil && headers.count > 0) {
        NSArray * keys = [headers allKeys];
        for (NSString *key in keys) {
            [_browser.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [_browser GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)GET:(NSString *)url headers:(NSDictionary *)headers params:(NSDictionary *)params response:(responseHtml)response{
    if (headers != nil && headers.count > 0) {
        NSArray * keys = [headers allKeys];
        for (NSString *key in keys) {
            [_browser.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [_browser GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



#pragma mark POST
-(void)POST:(NSString *)url headers:(NSDictionary *)headers formData:(NSDictionary *)formData response:(responseHtml)response{
    
    if (headers != nil && headers.count > 0) {
        NSArray * keys = [headers allKeys];
        for (NSString *key in keys) {
            [_browser.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [_browser POST:url parameters:formData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)POST:(NSString *)url uploadImage:(UIImage *)image serverAcceptFileName:(NSString*)acceptName fileName:(NSString*)fileName headers:(NSDictionary *)headers formData:(NSDictionary *)formData response:(responseHtml)response{
    if (headers != nil && headers.count > 0) {
        NSArray * keys = [headers allKeys];
        for (NSString *key in keys) {
            [_browser.requestSerializer setValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [_browser POST:url parameters:formData constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        NSData *data = UIImageJPEGRepresentation(image, 1);
        
        [formData appendPartWithFileData:data name:acceptName fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *html = [[[NSString alloc] initWithData:responseObject encoding:_encoding] replaceUnicode];
        response(html);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
