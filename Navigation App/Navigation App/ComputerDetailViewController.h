//
//  ComputerDetailViewController.h
//  Navigation App
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComputerDetailViewController : UIViewController
@property (strong, nonatomic) NSString *selectedComputer;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *computerImageView;

@end
