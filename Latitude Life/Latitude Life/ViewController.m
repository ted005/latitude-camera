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
#import "TWFlipForwardTransition.h"
#import "TWFlipBackwardTransition.h"
#import <AFHTTPRequestOperationManager.h>
#import <AFHTTPRequestOperation.h>


@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLLocation *location;

@property (strong, nonatomic) AFHTTPRequestOperationManager *opManager;

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
//    _manager.distanceFilter = 1000.f;
    
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
    _picker.delegate = self;
    
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

- (void)image: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"did finish......");
    
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //save to album
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
        
        //transition to ShareViewController
        ShareViewController *shareController = [self.storyboard instantiateViewControllerWithIdentifier:@"Share"];
        //        [shareController.img setImage:selectedImage];
        
        [self performSegueWithIdentifier:@"FlipForward" sender:self];
        
    } else {
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
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:_location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"Name: %@, Country: %@", placeMark.name, placeMark.country);
    }];
    
    //AFNetWorking GET request
    if (_opManager == nil) {
        _opManager = [AFHTTPRequestOperationManager manager];
        _opManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [_opManager GET:@"http://api.openweathermap.org/data/2.5/weather"
               parameters:@{@"lat": @35.f, @"lon" : @139.f}
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   NSDictionary *resp = (NSDictionary *)responseObject;
                   NSArray *weatherArr = (NSArray *)[resp valueForKey:@"weather"];
                   NSDictionary *weatherEle = (NSDictionary *)[weatherArr firstObject];
                   NSString *weather = (NSString *)[weatherEle valueForKey:@"main"];
                   NSLog(@"Weather: %@", weather);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"Error: %@", error);
                   //alert user
                   UIAlertController *alert = [UIAlertController
                                                    alertControllerWithTitle:@"Warning" message:@"Weather currently unavailable" preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                       //do nothing
                   }];
                   
                   [alert addAction:action];
                   [self presentViewController:alert animated:YES completion:^{
                       //do nothing
                   }];
                   
               }];

    }
    
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

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
     TWFlipForwardTransition *flip = [TWFlipForwardTransition new];
    
    return flip;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
             
             ShareViewController *secVC = (ShareViewController *)segue.destinationViewController;
             secVC.transitioningDelegate = self;
             [super prepareForSegue:segue sender:sender];
}


@end
