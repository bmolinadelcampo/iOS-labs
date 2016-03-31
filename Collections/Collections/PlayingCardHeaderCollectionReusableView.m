//
//  PlayingCardHeaderCollectionReusableView.m
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "PlayingCardHeaderCollectionReusableView.h"

@implementation PlayingCardHeaderCollectionReusableView

- (void)setDeckText:(NSString *)text
{
    self.deckLabel.text = text;
    NSString *imageName = [NSString stringWithFormat:@"%@.png", text];
    
    UIImage *cardImage = [UIImage imageNamed:imageName];
    self.suitImageView.image = cardImage;
}
@end
