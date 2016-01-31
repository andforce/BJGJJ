//
//  Browser.h
//  BJGJJ
//
//  Created by 迪远 王 on 16/1/25.
//  Copyright © 2016年 andforce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^responseHtml)(NSString* responseHtml);



@interface Browser : NSObject

-(instancetype)initWithStringEncoding:(NSStringEncoding) encoding;


-(void) POST:(NSString*) url headers:(NSDictionary*) headers formData:(NSDictionary*)formData response:(responseHtml)response;
-(void) POST:(NSString *)url uploadImage:(UIImage *)image serverAcceptFileName:(NSString*)acceptName fileName:(NSString*)fileName headers:(NSDictionary *)headers formData:(NSDictionary *)formData response:(responseHtml)response;



-(void) GET:(NSString*) url response:(responseHtml)response;

-(void) GET:(NSString*) url headers:(NSDictionary*) headers response:(responseHtml)response;

-(void) GET:(NSString*) url params:(NSDictionary*)params response:(responseHtml)response;

-(void) GET:(NSString*) url headers:(NSDictionary*) headers params:(NSDictionary*)params response:(responseHtml)response;

@end
