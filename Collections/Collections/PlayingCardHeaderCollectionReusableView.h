//
//  PlayingCardHeaderCollectionReusableView.h
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardHeaderCollectionReusableView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UIImageView *suitImageView;
@property (weak, nonatomic) IBOutlet UILabel *deckLabel;
-(void)setDeckText:(NSString *)text;
@end
