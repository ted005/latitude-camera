//
//  TWFlipBackwardTransition.m
//  Latitude Life
//
//  Created by Robbie on 15/4/20.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "TWFlipBackwardTransition.h"
#import "ViewController.h"
#import "ShareViewController.h"

@implementation TWFlipBackwardTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.6f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ShareViewController *toVC = (ShareViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    //增加透视的transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -0.002;
    containerView.layer.sublayerTransform = transform;
    
    //给fromVC和toVC分别设置相同的起始frame
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    fromView.frame = initialFrame;
    toView.frame = initialFrame;
    
    //改变View的锚点
    [self updateAnchorPointAndOffset:CGPointMake(0.0, 0.5) view:toView];
    
    //让toView的截图旋转90度
    toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //旋转fromView 90度
        toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
        
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.frame = initialFrame;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
}

//给传入的View改变锚点
-(void)updateAnchorPointAndOffset:(CGPoint)anchorPoint view:(UIView *)view{
    view.layer.anchorPoint = anchorPoint;
    view.layer.position    = CGPointMake(0, CGRectGetMidY(view.bounds));
}


@end
