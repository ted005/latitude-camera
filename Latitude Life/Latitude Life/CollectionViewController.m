
#import "CollectionViewController.h"
#import "TemplateCell.h"

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
    cell.label.text = [NSString stringWithFormat:@"%@", [_templateCellTexts objectAtIndex:indexPath.row]];
    return cell;
}

-(void)initTemoplateCellTextsArray{
    _templateCellTexts = [[NSMutableArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", nil];
}

-(void)initTemoplateCellImagesArray{
    _templateCellImages = [[NSMutableArray alloc] initWithObjects:nil];
}


@end

