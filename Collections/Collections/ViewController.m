//
//  ViewController.m
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardCollectionViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *diamondCardsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table-background.png"]];
    self.diamondCardsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int counter = 1; counter < 14; counter++) {
        NSString *imageName = [NSString stringWithFormat:@"d%i.png", counter];
        UIImage *myImage = [UIImage imageNamed:imageName];
        [self.diamondCardsArray addObject:myImage];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.diamondCardsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playingCard" forIndexPath:indexPath];
    cell.cardImage = self.diamondCardsArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UIImage *card = self.diamondCardsArray[indexPath.row];
    CGSize retval = card.size;
    retval.height += 4;
    retval.width += 4;
    return retval;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
