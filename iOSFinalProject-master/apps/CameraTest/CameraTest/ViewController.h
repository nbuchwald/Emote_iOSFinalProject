//
//  ViewController.h
//  CameraTest
//
//  Created by Boisy Pitre on 1/28/16.
//  Copyright © 2016 Affectiva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Affdex/Affdex.h>

@interface ViewController : UIViewController <AFDXDetectorDelegate>

//@property (strong, nonatomic) IBOutlet UIButton *CustomSegueButton;
@property (strong) AFDXDetector *detector;
@property (strong) IBOutlet UIImageView *cameraView;
@property (strong) IBOutlet UILabel *smileLabel;

@property (strong, nonatomic) IBOutlet UIButton *SecondViewController;

@end

