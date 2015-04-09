//
//  ViewController.m
//  Latitude Life
//
//  Created by Robbie on 15/4/7.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@property UIImagePickerController *camera;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _camera = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    _camera.sourceType = UIImagePickerControllerSourceTypeCamera;
    _camera.showsCameraControls = NO;
    
    [self.view insertSubview:_camera.view atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
