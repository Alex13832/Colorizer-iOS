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

#import <opencv2/core.hpp>

@interface ImageUtils : NSObject {
    cv::Mat mat;
}

/**
 \brief Converts a single grayscale image to a color image.
 \link https://docs.opencv.org/3.4/d6/d39/samples_2dnn_2colorization_8cpp-example.html
 \return A colorized image.
 */
-(UIImage*)colorize;

/**
 \brief Sets the the image to use when converting a single grayscale image.
 \param[in] img A grayscale image.
 */
-(void)setImg:(UIImage*) img;

@end

#endif /* ImageUtils_h */
