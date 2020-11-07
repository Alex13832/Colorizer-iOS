//
//  ImageUtilsWrapper.hpp
//  Colorizer_iOS
//
//  Created by Alexander Karlsson on 2019-12-30.
//  Copyright © 2019 Alexander Karlsson. All rights reserved.
//

#ifndef ImageUtilsWrapper_h
#define ImageUtilsWrapper_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtilsWrapper : NSObject

/**
 \brief Converts a grayscale image to color.
 \return A colorized image.
 */
-(UIImage*)colorizeImage:(UIImage*)img;

@end

#endif /* ImageUtilsWrapper_h */
