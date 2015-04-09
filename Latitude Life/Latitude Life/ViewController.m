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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _picker = [self.storyboard instantiateViewControllerWithIdentifier:@"Camera"];
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _picker.showsCameraControls = NO;
    
    //add auto layout manually
    _picker.view.frame = CGRectMake(0, 0, 400, 850);
    
    [self.view insertSubview:_picker.view atIndex:0];
}

- (IBAction)shoot:(UIButton *)sender {
    NSLog(@"shoot.......");
    
}
- (IBAction)toggleFlash:(UIButton *)sender {
    NSLog(@"flash.......");
}
- (IBAction)toggleFrontCamera:(UIButton *)sender {
    NSLog(@"front.......");
}
- (IBAction)showPhoto:(UIButton *)sender {
    NSLog(@"showPhoto.......");
}
- (IBAction)showTemplate:(UIButton *)sender {
    NSLog(@"showTemplate.......");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
