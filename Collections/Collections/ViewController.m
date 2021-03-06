//
//  ViewController.m
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardCollectionViewCell.h"
#import "PlayingCardHeaderCollectionReusableView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *diamondCardsArray;
@property (strong, nonatomic) NSMutableArray *spadeCardsArray;
@property (strong, nonatomic) NSMutableArray *heartCardsArray;
@property (strong, nonatomic) NSMutableArray *clubCardsArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table-background.png"]];
    self.diamondCardsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.spadeCardsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.clubCardsArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.heartCardsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int counter = 1; counter < 14; counter++) {
        NSString *imageName = [NSString stringWithFormat:@"d%i.png", counter];
        UIImage *myImage = [UIImage imageNamed:imageName];
        [self.diamondCardsArray addObject:myImage];
        
        imageName = [NSString stringWithFormat:@"s%i.png", counter];
        myImage = [UIImage imageNamed:imageName];
        [self.spadeCardsArray addObject:myImage];
        
        imageName = [NSString stringWithFormat:@"h%i.png", counter];
        myImage = [UIImage imageNamed:imageName];
        [self.heartCardsArray addObject:myImage];
        
        imageName = [NSString stringWithFormat:@"c%i.png", counter];
        myImage = [UIImage imageNamed:imageName];
        [self.clubCardsArray addObject:myImage];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.diamondCardsArray count];
            break;
        case 1:
            return [self.spadeCardsArray count];
            break;
        case 2:
            return [self.heartCardsArray count];
            break;
        case 3:
            return [self.clubCardsArray count];
            break;
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"playingCard" forIndexPath:indexPath];
    switch ([indexPath section]) {
        case 0:
            cell.cardImage = self.diamondCardsArray[indexPath.row];
            break;
        case 1:
            cell.cardImage = self.spadeCardsArray[indexPath.row];
            break;
        case 2:
            cell.cardImage = self.heartCardsArray[indexPath.row];
            break;
        case 3:
            cell.cardImage = self.clubCardsArray[indexPath.row];
            break;
        default:
            break;
    }
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"playingCardHeader" forIndexPath:indexPath];
    NSString *searchTerm;
    switch ([indexPath section]) {
        case 0:
            searchTerm = @"Diamonds";
            break;
        case 1:
            searchTerm = @"Spades";
            break;
        case 2:
            searchTerm = @"Hearts";
            break;
        case 3:
            searchTerm = @"Clubs";
            break;
        default:
            break;
    }
    [headerView setDeckText:searchTerm];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCollectionViewCell *cell = (PlayingCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor yellowColor];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCollectionViewCell *cell = (PlayingCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardCollectionViewCell *cell = (PlayingCardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    UIImageView *backView = [[UIImageView alloc] initWithImage:backImage];
    [UIView transitionWithView:cell.contentView
                      duration:0.7
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{[cell.contentView addSubview:backView];}
                    completion:^(BOOL finished){
                        if (finished) {
                            [UIView transitionWithView:cell.contentView
                                              duration:0.7
                                               options:UIViewAnimationOptionTransitionFlipFromLeft
                                            animations:^{[backView removeFromSuperview];}
                                            completion:NULL];
                        }
                    }
     ];
}
@end