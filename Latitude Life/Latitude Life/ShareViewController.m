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

@property UIView *sharePopup;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"t22" ofType:@"png"];
    
    
    UIImage *momentsIcon = [UIImage imageWithContentsOfFile:path];
    _sharePopup = [[UIView alloc] initWithFrame:CGRectMake(200, self.view.frame.size.height, 0, 0)];
    
    UIImageView *moments = [[UIImageView alloc] initWithImage:momentsIcon];
    
    [_sharePopup addSubview:moments];
//    _sharePopup.backgroundColor = [UIColor redColor];
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
    
    if (!sender.selected) {
        [self.view insertSubview:_sharePopup atIndex:0];
        
        POPSpringAnimation *popupAnim = [POPSpringAnimation animation];
        popupAnim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        popupAnim.toValue=[NSValue valueWithCGRect:CGRectMake(0, 500, 375, 55)];
        popupAnim.name=@"popupShare";
        popupAnim.delegate=self;
        [_sharePopup pop_addAnimation:popupAnim forKey:@"popupShare"];
        sender.selected = YES;
    } else {
        
        POPSpringAnimation *hideAnim = [POPSpringAnimation animation];
        hideAnim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
        hideAnim.toValue=[NSValue valueWithCGRect:CGRectMake(200, self.view.frame.size.height, 0, 0)];
        hideAnim.name=@"hideShare";
        hideAnim.delegate=self;
        [_sharePopup pop_addAnimation:hideAnim forKey:@"hideShare"];
        
        [_sharePopup removeFromSuperview];
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
