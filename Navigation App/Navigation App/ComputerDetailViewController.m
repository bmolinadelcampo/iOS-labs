//
//  ComputerDetailViewController.m
//  Navigation App
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ComputerDetailViewController.h"

@interface ComputerDetailViewController ()

@end

@implementation ComputerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descriptionLabel.text = self.selectedComputer;
    NSString *fullImageName = [NSString stringWithFormat:@"%@.png", self.selectedComputer];
    UIImage *myImage = [UIImage imageNamed:fullImageName];
    self.computerImageView.image = myImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
