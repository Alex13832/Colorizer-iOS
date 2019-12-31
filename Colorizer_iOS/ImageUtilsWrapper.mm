//
//  ImageUtilsWrapper.m
//  Colorizer_iOS
//
//  Created by Alexander Karlsson on 2019-12-30.
//  Copyright © 2019 Alexander Karlsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageUtilsWrapper.hpp"
#import "ImageUtils.hpp"
#import <iostream>
#import <CoreGraphics/CoreGraphics.h>
#import <Vision/Vision.h>

@implementation ImageUtilsWrapper

ImageUtils *im_utils;

-(id)init {
    im_utils = [[ImageUtils alloc] init];
    return self;
}

- (UIImage *)colorizeImage:(UIImage *)img {
    [im_utils setImg:img];
    UIImage *color = [im_utils colorize];
    return color;
}

@end
