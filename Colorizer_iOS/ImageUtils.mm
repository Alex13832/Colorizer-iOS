//
//  ImageUtils.m
//  Colorizer_iOS
//
//  Created by Alexander Karlsson on 2019-12-30.
//  Copyright © 2019 Alexander Karlsson. All rights reserved.
//

#import "ImageUtils.hpp"

#import <Foundation/Foundation.h>

#import <opencv2/photo.hpp>
#import <opencv2/dnn.hpp>
#import <opencv2/imgcodecs/ios.h>

using namespace cv;
using namespace cv::dnn;

namespace {

static float hull_pts[] = {
    -90., -90., -90., -90., -90., -80., -80., -80., -80., -80., -80., -80., -80., -70., -70., -70., -70., -70., -70., -70., -70.,
    -70., -70., -60., -60., -60., -60., -60., -60., -60., -60., -60., -60., -60., -60., -50., -50., -50., -50., -50., -50., -50., -50.,
    -50., -50., -50., -50., -50., -50., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -40., -30.,
    -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -30., -20., -20., -20., -20., -20., -20., -20.,
    -20., -20., -20., -20., -20., -20., -20., -20., -20., -10., -10., -10., -10., -10., -10., -10., -10., -10., -10., -10., -10., -10.,
    -10., -10., -10., -10., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 10., 10., 10., 10., 10., 10., 10.,
    10., 10., 10., 10., 10., 10., 10., 10., 10., 10., 10., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20., 20.,
    20., 20., 20., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 30., 40., 40., 40., 40.,
    40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 40., 50., 50., 50., 50., 50., 50., 50., 50., 50., 50.,
    50., 50., 50., 50., 50., 50., 50., 50., 50., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60., 60.,
    60., 60., 60., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 70., 80., 80., 80.,
    80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 80., 90., 90., 90., 90., 90., 90., 90., 90., 90., 90.,
    90., 90., 90., 90., 90., 90., 90., 90., 90., 100., 100., 100., 100., 100., 100., 100., 100., 100., 100., 50., 60., 70., 80., 90.,
    20., 30., 40., 50., 60., 70., 80., 90., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., -20., -10., 0., 10., 20., 30., 40., 50.,
    60., 70., 80., 90., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., 100., -40., -30., -20., -10., 0., 10., 20.,
    30., 40., 50., 60., 70., 80., 90., 100., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., 100., -50.,
    -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., 100., -60., -50., -40., -30., -20., -10., 0., 10., 20.,
    30., 40., 50., 60., 70., 80., 90., 100., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90.,
    100., -80., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., -80., -70., -60., -50.,
    -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., 90., -90., -80., -70., -60., -50., -40., -30., -20., -10.,
    0., 10., 20., 30., 40., 50., 60., 70., 80., 90., -100., -90., -80., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30.,
    40., 50., 60., 70., 80., 90., -100., -90., -80., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70.,
    80., -110., -100., -90., -80., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., -110., -100.,
    -90., -80., -70., -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., 80., -110., -100., -90., -80., -70.,
    -60., -50., -40., -30., -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., -110., -100., -90., -80., -70., -60., -50., -40., -30.,
    -20., -10., 0., 10., 20., 30., 40., 50., 60., 70., -90., -80., -70., -60., -50., -40., -30., -20., -10., 0.};

}

@implementation ImageUtils {
    Net net;
}

-(id)init {
    if ( self = [super init] ) {
        // Define what files to read
        NSString *protoFileName = [[NSBundle mainBundle] pathForResource:@"colorization_deploy_v2" ofType:@"prototxt"];
        const char* protoCString = [protoFileName UTF8String];
        
        NSString *modelFileName = [[NSBundle mainBundle] pathForResource:@"colorization_release_v2" ofType:@"caffemodel"];
        const char* modelFileNameCString = [modelFileName UTF8String];
        
        std::string modelTxt = std::string(protoCString);
        std::string modelBin = std::string(modelFileNameCString);
        
        // Initialize net
        net = readNetFromCaffe(modelTxt, modelBin);
        net.setPreferableTarget(cv::dnn::DNN_TARGET_OPENCL);
    }
    
    return self;
}

-(void)setImg:(UIImage*) img {
    UIImageToMat(img, mat);
    
    // Check if image is grayscale or "grayscale" (actually color), and convert to BGR.
    if (mat.channels() == 1) {
        cv::cvtColor(mat, mat, CV_GRAY2BGR);
    } else if (mat.channels() == 4) {
        cv::cvtColor(mat, mat, CV_BGRA2BGR);
    }
}

- (UIImage *)colorize {
    // fixed input size for the pretrained network
    const int W_in = 224;
    const int H_in = 224;
    
    // setup additional layers:
    int sz[] = {2, 313, 1, 1};
    cv::Mat pts_in_hull(4, sz, CV_32F, hull_pts);
    cv::Ptr<dnn::Layer> class8_ab = net.getLayer("class8_ab");
    class8_ab->blobs.push_back(pts_in_hull);
    cv::Ptr<dnn::Layer> conv8_313_rh = net.getLayer("conv8_313_rh");
    conv8_313_rh->blobs.push_back(Mat(1, 313, CV_32F, Scalar(2.606)));
    
    // extract L channel and subtract mean
    cv::Mat lab, L, input;
    mat.convertTo(mat, CV_32F, 1.0 / 255);
    cv::cvtColor(mat, lab, COLOR_BGR2Lab);
    cv::extractChannel(lab, L, 0);
    cv::resize(L, input, cv::Size(W_in, H_in));
    input -= 50;
    
    // run the L channel through the network
    cv::Mat inputBlob = blobFromImage(input);
    net.setInput(inputBlob);
    cv::Mat result = net.forward();
    
    // retrieve the calculated a,b channels from the network output
    cv::Size siz(result.size[2], result.size[3]);
    cv::Mat a = Mat(siz, CV_32F, result.ptr(0, 0));
    cv::Mat b = Mat(siz, CV_32F, result.ptr(0, 1));
    cv::resize(a, a, mat.size());
    cv::resize(b, b, mat.size());
    
    // merge, and convert back to RGB
    cv::Mat color, chn[] = {L, a, b};
    cv::merge(chn, 3, lab);
    cv::cvtColor(lab, color, COLOR_Lab2RGB);
    
    color.convertTo(color, CV_8UC4, 255);
    
    return MatToUIImage(color);
}

@end
