
#import "CollectionViewController.h"
#import "TemplateCell.h"
#import "TWSimpleTemplateView.h"

@implementation CollectionViewController

-(void)viewDidLoad
{
    [self initTemoplateCellTextsArray];
    [self initTemoplateCellImagesArray];
    
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.collectionView setFrame:CGRectMake(0, 500, 375, 55)];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 8;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    [cell.button setTitle:[NSString stringWithFormat:@"%@", [_templateCellTexts objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    //add action for button
    [cell.button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    //to distinguish each button
    [cell.button setTag:indexPath.row];
    
    return cell;
}


-(void)btnPressed:(id)sender{
    UIButton* btn = (UIButton*)sender;
    UIView *superview = btn.superview.superview.superview.superview;//pickerView
    UIView *cameraView = [[superview subviews] firstObject];
    UIImagePickerController* controller = (UIImagePickerController*)[cameraView nextResponder];
    
    //change camera overlay view(template)
    controller.cameraOverlayView = nil;
    NSLog(@"%ld is pressed.", (long)btn.tag);
    
    switch (btn.tag) {
        case 0:
            _simpleTemplate = [[[NSBundle mainBundle] loadNibNamed:@"TWSimpleTemplateView" owner:nil options:nil] firstObject];
            [_simpleTemplate setFrame:CGRectMake(0, 450, 400, 100)];
            _simpleTemplate.backgroundColor = [UIColor clearColor];
            controller.cameraOverlayView = _simpleTemplate;
            
            break;
        case 1:
            _simpleTemplate = [[[NSBundle mainBundle] loadNibNamed:@"TWSimpleTemplateView" owner:nil options:nil] firstObject];
            [_simpleTemplate setFrame:CGRectMake(0, 450, 400, 100)];
            _simpleTemplate.backgroundColor = [UIColor clearColor];
            controller.cameraOverlayView = _simpleTemplate;
            break;
        
            
        default:
            break;
    }
    
    //dismiss template view
    [self.collectionView removeFromSuperview];
    //TODO template button selected = No;
    
}

-(void)initTemoplateCellTextsArray{
    _templateCellTexts = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", nil];
}

-(void)initTemoplateCellImagesArray{
    _templateCellImages = [[NSMutableArray alloc] initWithObjects:nil];
}


@end

