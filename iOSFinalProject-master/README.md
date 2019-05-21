![Affectiva Logo](http://developer.affectiva.com/images/logo.png)

###Copyright (c) 2016 Affectiva Inc. <br/>
The Affdex SDK is covered by our [SDK License Agreement](http://developer.affectiva.com/sdklicense)<br/>
The AffdexMe app is covered by the MIT license.  See the file [license.txt](license.txt) for copying permission.

*****************************

These iOS sample apps demonstrate the use of the Affectiva iOS SDK. Feel free to use this as a starting point for your own apps.

CameraTest
----------
This is a simple app that demonstrates how to to use the Affdex SDK with the built-in camera on your iOS device.

For developer documentation, sample code, and other information, please visit our website:
http://developer.affectiva.com

The SDK License Agreement is available at:
http://developer.affectiva.com/sdklicense

How To Build
----------
All projects build under Xcode 7 or later. In order to build each one, you will need to:

- Have a valid CocoaPods installation on your machine ([visit the CocoaPods website for more info](http://www.cocoapods.org).
)
- With CocoaPods installed, launch Terminal.app, change into the project directory you want to build, then type the following command to associate the Affdex SDK with that project:

```
pod install
```

- CocoaPods will generate an Xcode workspace file ending in .xcworkspace -- open it in Xcode (do not the .xcodeproj file).
- Build the project for your simulator or device.  (For apps that use the camera, you will need to build for the device since the simulator cannot access the Mac's built-in camera.)

