//
//  PlayingCardCollectionViewCell.m
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "PlayingCardCollectionViewCell.h"

@implementation PlayingCardCollectionViewCell

- (void)setCardImage:(UIImage *)cardImage
{
    if(_cardImage != cardImage) {
        _cardImage = cardImage;
    }
    self.imageView.image = self.cardImage;
}
@end
