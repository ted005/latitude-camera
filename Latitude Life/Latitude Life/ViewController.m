//
//  ViewController.m
//  Latitude Life
//
//  Created by Robbie on 15/4/7.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIView *toolbar;
@property UICollectionViewController *templates;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _picker = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _picker.showsCameraControls = NO;
    _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    
    //add auto layout manually
    _picker.view.frame = CGRectMake(0, 0, 400, 850);
    
    [self.view insertSubview:_picker.view atIndex:0];
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (IBAction)shoot:(UIButton *)sender {
    NSLog(@"shoot.......");
    [_picker takePicture];
    
}
- (IBAction)toggleFlash:(UIButton *)sender {
    NSLog(@"flash.......");
//    _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
    if (_picker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff) {
        _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    } else {
        _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
//    _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
}
- (IBAction)toggleFrontCamera:(UIButton *)sender {
    NSLog(@"front.......");
    
    
    [UIView transitionWithView:_picker.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        [_picker.view removeFromSuperview];
        
        if (_picker.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
            _picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        } else {
            _picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        }
        [self.view insertSubview:_picker.view atIndex:0];
        
    } completion:^(BOOL finished) {
        //do nothing
    }];
    
}
- (IBAction)showPhoto:(UIButton *)sender {
    NSLog(@"showPhoto.......");
//    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}
- (IBAction)showTemplate:(UIButton *)sender {
    NSLog(@"showTemplate.......");
    _templates = [self.storyboard instantiateViewControllerWithIdentifier:@"Templates"];
    [_templates.view setBackgroundColor:[UIColor whiteColor]];
    [_templates.view setFrame:CGRectMake(0, 300, 400, 100)];
    [self presentViewController:_templates animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"did finish......");
}

@end
