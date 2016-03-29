//
//  CharactersListViewController.h
//  Table Challenge
//
//  Created by Belén Molina del Campo on 27/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharactersListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *selectedShow;
@property (strong, nonatomic) NSArray *charactersForSelectedShow;
@property (strong, nonatomic) UIColor *backgroundColour;

@end
