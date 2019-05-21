//
//  ViewController.m
//  CameraTest
//
//  Created by Boisy Pitre on 1/28/16.
//  Copyright © 2016 Affectiva. All rights reserved.
//

#import "ViewController.h"
#import "SmiledViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
//@property (strong, nonatomic) IBOutlet UIButton *CustomSegueButton;

@end

@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"CustomSeguetoSmiledView"]) {
        if(![self.navigationController.topViewController isKindOfClass:[SecondViewController class]]) {
        SecondViewController *destinationViewController = (SecondViewController*)segue.destinationViewController;
        }
    }
    //            SmiledViewController *vc = [segue destinationViewController];
}

#pragma mark -
#pragma mark Convenience Methods

- (void)goToNextView {
    [self performSegueWithIdentifier:@"CustomSegueSecondView" sender:self];
}

//- (void)viewDidLoad {
//    [self performSelector:@selector(goToNextView) withObject:nil afterDelay:5];
//}

// This is a convenience method that is called by the detector:hasResults:forImage:atTime: delegate method below.
// You will want to do something with the face (or faces) found.
- (void)processedImageReady:(AFDXDetector *)detector image:(UIImage *)image faces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
{
    // iterate on the values of the faces dictionary
    for (AFDXFace *face in [faces allValues])
    {
        // Here's where you actually "do stuff" with the face object (e.g. examine the emotions, expressions,
        // emojis, and other metrics).
        NSLog(@"%@", face);
        NSLog(@"IAMHERE");
        NSLog(@"%f", face.expressions.smile);
        if (face.expressions.smile > 50){
            NSLog(@"Smile is not happening");
            self.smileLabel.text = @"You are smiling";
            if(![self.navigationController.topViewController isKindOfClass:[SecondViewController class]]) {
            [self performSelector:@selector(goToNextView) withObject:nil];
            }
            break;
        }
        else{
            self.smileLabel.text =@"You are not smiling";
        }
        
        
    }
}

// This is a convenience method that is called by the detector:hasResults:forImage:atTime: delegate method below.
// It handles all UNPROCESSED images from the detector. Here I am displaying those images on the camera view.
- (void)unprocessedImageReady:(AFDXDetector *)detector image:(UIImage *)image atTime:(NSTimeInterval)time;
{
    ViewController * __weak weakSelf = self;
    
    // UI work must be done on the main thread, so dispatch it there.
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.cameraView setImage:image];
    });
}

- (void)destroyDetector;
{
    [self.detector stop];
}

- (void)createDetector;
{
    // ensure the detector has stopped
    [self destroyDetector];
    
    // iterate through the capture devices to find the front position camera
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == AVCaptureDevicePositionFront)
        {
            self.detector = [[AFDXDetector alloc] initWithDelegate:self
                                                usingCaptureDevice:device
                                                      maximumFaces:1];
            self.detector.maxProcessRate = 5;
            
            // turn on all classifiers (emotions, expressions, and emojis)
            [self.detector setDetectAllEmotions:YES];
            [self.detector setDetectAllExpressions:YES];
            [self.detector setDetectEmojis:YES];
            
            // turn on gender and glasses
            self.detector.gender = TRUE;
            self.detector.glasses = TRUE;
            
            // start the detector and check for failure
            NSError *error = [self.detector start];
            
            if (nil != error)
            {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detector Error"
                                                                               message:[error localizedDescription]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alert animated:YES completion:
                 ^{}
                 ];
                
                return;
            }
            
            break;
        }
    }
}





#pragma mark -
#pragma mark AFDXDetectorDelegate Methods

// This is the delegate method of the AFDXDetectorDelegate protocol. This method gets called for:
// - Every frame coming in from the camera. In this case, faces is nil
// - Every PROCESSED frame that the detector
- (void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time;
{
    if (nil == faces)
    {
        [self unprocessedImageReady:detector image:image atTime:time];
    }
    else
    {
        [self processedImageReady:detector image:image faces:faces atTime:time];
    }
}


#pragma mark -
#pragma mark View Methods

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    [self createDetector]; // create the dector just before the view appears
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [super viewWillDisappear:animated];
    [self destroyDetector]; // destroy the detector before the view disappears
}

- (void)didReceiveMemoryWarning;
{
    [super didReceiveMemoryWarning];
}

@end
