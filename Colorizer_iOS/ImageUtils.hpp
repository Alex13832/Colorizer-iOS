//
//  ImageUtils.hpp
//  Colorizer_iOS
//
//  Created by Alexander Karlsson on 2019-12-30.
//  Copyright © 2019 Alexander Karlsson. All rights reserved.
//

#ifndef ImageUtils_h
#define ImageUtils_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#import "opencv2/core.hpp"

@interface ImageUtils : NSObject {
    cv::Mat mat;
}

-(UIImage*)colorize ;
-(void)setImg:(UIImage*) img;

@end

#endif /* ImageUtils_h */
