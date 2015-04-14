//
//  ViewController.m
//  Latitude Life
//
//  Created by Robbie on 15/4/7.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewController.h"
#import "LineLayout.h"

@interface ViewController ()

@property UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIView *toolbar;
@property CollectionViewController *templates;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    
    _picker = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _picker.showsCameraControls = NO;
    _picker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    _picker.view.backgroundColor = [UIColor redColor];
    
    //add auto layout manually
    _picker.view.frame = CGRectMake(0, 0, 400, 850);
    
    [self.view insertSubview:_picker.view atIndex:0];
    [self.view setBackgroundColor:[UIColor greenColor]];
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
    if (!sender.selected) {
        LineLayout* lineLayout = [[LineLayout alloc] init];
        _templates = [[CollectionViewController alloc] initWithCollectionViewLayout:lineLayout];
        
        //    [_templates.view setBackgroundColor:[UIColor whiteColor]];
        //    [_templates.view setFrame:CGRectMake(0, 500, 400, 60)];
        //    [self presentViewController:_templates animated:YES completion:nil];
        [self.view insertSubview:_templates.collectionView aboveSubview:_picker.view];
        sender.selected = YES;
    } else {
        if (_templates != nil) {
            [_templates.collectionView removeFromSuperview];
            sender.selected = NO;
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"did finish......");
}

//- (void)updateViewConstraints{
//    CGRect viewFrame = CGRectMake(50.f, 10.f, 150.f, 150.f);
//    
////    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [_picker.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//        NSLayoutConstraint *viewTop = [NSLayoutConstraint constraintWithItem:_picker.view
//                                                                   attribute:NSLayoutAttributeTop
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self.view
//                                                                   attribute:NSLayoutAttributeTop
//                                                                  multiplier:1
//                                                                    constant:CGRectGetMinY(viewFrame)];
//    
//        [self.view addConstraint:viewTop];
//    
//    [super updateViewConstraints];
//}

@end
