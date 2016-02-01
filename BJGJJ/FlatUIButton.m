//
//  LeftDrawerItem.m
//  iOSMaps
//
//  Created by 迪远 王 on 15/12/12.
//  Copyright © 2015年 andforce. All rights reserved.
//

#import "FlatUIButton.h"
#import "CommonUtils.h"
#import "UIImage+Tint.h"
#import "UIColor+MyColor.h"


#define kMarginLeft 15

@implementation FlatUIButton



-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
        UIColor *blueHighLightColor = [UIColor colorWithBlueHighLight];
        
        
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self setTitleColor:blueHighLightColor forState:UIControlStateHighlighted];
//        [self setTitleColor:blueHighLightColor forState:UIControlStateSelected];
        
        [self setBackgroundColor:[UIColor colorWithRed:255 greed:84 blue:107]];
        
        
        UIImage *normalImage = [CommonUtils createImageWithColor:[UIColor colorWithRed:255 greed:105 blue:104]];
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        
//        
//        UIImage *highLight = [CommonUtils createImageWithColor:[UIColor colorWithRed:255 greed:84 blue:107]];
//        [self setBackgroundImage:highLight forState:UIControlStateHighlighted];
//        [self setBackgroundImage:highLight forState:UIControlStateSelected];
        
        [self setCorner];
    }
    
    return self;
}


-(void) setCorner{
//    UIColor * borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
//    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5.0;
    
}

@end
