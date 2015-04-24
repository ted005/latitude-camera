#import "TemplateCell.h"

@implementation Cell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
//        self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//        self.label.font = [UIFont boldSystemFontOfSize:50.0];
//        self.label.backgroundColor = [UIColor clearColor];
//        self.label.textColor = [UIColor blackColor];

        [self.contentView addSubview:_button];
        
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
//        imageView.frame = CGRectMake(25, 125, 150, 75);
//        [self.contentView addSubview:imageView];
        
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
