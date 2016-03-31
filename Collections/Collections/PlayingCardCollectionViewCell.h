//
//  PlayingCardCollectionViewCell.h
//  Collections
//
//  Created by Belén Molina del Campo on 31/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIImage *cardImage;
@end
