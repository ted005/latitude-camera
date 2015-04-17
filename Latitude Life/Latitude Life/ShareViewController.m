//
//  ShareViewController.m
//  Latitude Life
//
//  Created by Robbie on 15/4/17.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "ShareViewController.h"
#import <pop/POP.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)share:(UIButton *)sender {
    NSLog(@"share......");
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height, 0, 0)];
    view.backgroundColor = [UIColor redColor];

    
    if (!sender.selected) {
                [self.view insertSubview:view atIndex:0];
        
        POPSpringAnimation *basicAnimation = [POPSpringAnimation animation];
        basicAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        basicAnimation.toValue=[NSValue valueWithCGRect:CGRectMake(0, 500, 375, 55)];
        basicAnimation.name=@"SomeAnimationNameYouChoose";
        basicAnimation.delegate=self;
        [view pop_addAnimation:basicAnimation forKey:@"WhatEverNameYouWant"];
        sender.selected = YES;
    } else {
        [view removeFromSuperview];
        sender.selected = NO;
    }
    
    
}
- (IBAction)back:(UIButton *)sender {
    NSLog(@"back......");
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}

@end
