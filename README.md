Colorizer iOS
===============

Source code for image colorizing in iOS. 

## Background
A really impressive project where grayscale images were transformed into color images was found at the [OpenCV example section](https://docs.opencv.org/3.4/d6/d39/samples_2dnn_2colorization_8cpp-example.html).

To transform grayscale images into color images OpenCV use a Deep Neural Network model, trained in Caffe. OpenCV can read and use these models. The model was trained by Richard Zhang at the university of Berkely. More information [here](http://richzhang.github.io/colorization/) and in this Bibtex:

```
@inproceedings{zhang2016colorful,
  title={Colorful Image Colorization},
  author={Zhang, Richard and Isola, Phillip and Efros, Alexei A},
  booktitle={ECCV},
  year={2016}
}
```

The code was rewritten for Objective-C++ and Swift and an app was made. When developing the app the goal was to produce a simple UI that takes an input image and then transforms it to a color image.

## Dependencies
The app depends on OpenCV. It should be straightforward to add the OpenCV library to Xcode. The code that depend on OpenCV is Objective-C++ (.mm). There is a bridging-header provided not to expose C++ code to Swift.

Due to OpenCV's size, the framework was not pushed to this repository. Download it from [here](https://opencv.org/releases/), in this project `OpenCV-3.4.9` is used. Unzip `opencv2.framework.zip`, drag it to Xcode and select "Copy items if needed". The app should work with previous releases, which may reduce the app size.

<img src="./images/opencv.png" width="1000"/>

To make Xcode understand that the framework exists, see the images below:

<img src="./images/opencv1.png" width="1000"/>
<img src="./images/opencv2.png" width="1000"/>

## Interface
To scan and crop photos with the built in camera is out of the scope for this app. There are other apps available in the App Store for that purpose, [PhotoScan by Google Photos](https://apps.apple.com/us/app/photoscan-by-google-photos/id1165525994) for instance.

### Main interface
Tap on the screen to open the camera roll and choose a photo. The arrow becomes green and the photo can now be colorized. A colorized image will be shown and the share button becomes green, the image can now be saved. To compare the result and the input, there is a segment button go go between these.

<p float="left">
  <img src="./images/interface.png" width="300" />
  <img src="./images/interface_and_photo.png" width="300" /> 
</p>
<p float="left">
  <img src="./images/interface_color.png" width="300" /> 
  <img src="./images/interface_share.png" width="300" /> 
</p>


## Examples

<p float="left">
  <img src="./images/example1_gray.png" width="300" />
  <img src="./images/example1_color.png" width="300" /> 
</p>

<p float="left">
  <img src="./images/example2_gray.png" width="300" />
  <img src="./images/example2_color.png" width="300" /> 
</p>

<p float="left">
  <img src="./images/example3_gray.png" width="300" />
  <img src="./images/example3_color.png" width="300" /> 
</p>

<p float="left">
  <img src="./images/example4_gray.png" width="300" />
  <img src="./images/example4_color.png" width="300" /> 
</p>