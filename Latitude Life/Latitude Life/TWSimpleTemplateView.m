//
//  TWSimpleTemplateView.m
//  Latitude Life
//
//  Created by Robbie on 15/4/22.
//  Copyright (c) 2015年 Mattie. All rights reserved.
//

#import "TWSimpleTemplateView.h"

@implementation TWSimpleTemplateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)aRect{
    self = [super initWithFrame:aRect];
    if (self) {
        //
//        self.frame = CGRectMake(0, 0, 400, 100);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end