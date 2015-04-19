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
#import "ShareViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLLocation *location;

@property UIImagePickerController *picker;
@property (weak, nonatomic) IBOutlet UIView *toolbar;
@property CollectionViewController *templates;

@property UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //location
    _manager = [[CLLocationManager alloc] init];
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_manager requestWhenInUseAuthorization];
    }
    [_manager startUpdatingLocation];
    
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
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *library = [[UIImagePickerController alloc] init];
        library.delegate = self;
        library.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        library.allowsEditing = NO;
        
        [self presentViewController:library animated:YES completion:^{
            //do nothing
        }];
    }
    
}

- (IBAction)showTemplate:(UIButton *)sender {
    NSLog(@"showTemplate.......");
    if (!sender.selected) {
        LineLayout* lineLayout = [[LineLayout alloc] init];
        _templates = [[CollectionViewController alloc] initWithCollectionViewLayout:lineLayout];
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
    
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        /**
        //show selected image
        [_picker.view removeFromSuperview];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:selectedImage];
        
        imgView.frame = _picker.view.frame;
        
        //replace camera with image
        [_picker removeFromParentViewController];
        [self.view insertSubview:imgView atIndex:0];
        
        //replace toolbar with shareToolBar
        UIViewController *shareController = [self.storyboard instantiateViewControllerWithIdentifier:@"Share"];
        shareController.view.frame = _toolbar.frame;
        [_toolbar removeFromSuperview];
        [self.view addSubview:shareController.view];
         */
        
        ShareViewController *shareController = [self.storyboard instantiateViewControllerWithIdentifier:@"Share"];
//        [shareController.img setImage:selectedImage];
        
        [self presentViewController:shareController animated:YES completion:^{
            //do nothing
            
        }];
        
    }];
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

// Location Manager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [locations lastObject];
    NSLog(@"Latitude: %f, Longitude: %f, Altitude: %f, Timestamp: %@", _location.coordinate.latitude, _location.coordinate.longitude, _location.altitude, _location.timestamp);
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
                if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {                [manager requestWhenInUseAuthorization];
                }
                break;
            case kCLAuthorizationStatusDenied:
                //alert user to enable location in settings
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Hello" preferredStyle:UIAlertControllerStyleAlert];
                
                
//                UIAlertAction *info = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    //do nothing
//                }];
                
//                [alert addAction:info];
//                [self presentViewController:alert animated:YES completion:nil];
                
                break;
            default:
                break;
        }
}

@end
