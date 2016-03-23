//
//  ViewController.m
//  Navigation App
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#import "ComputerListTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ComputerListTableViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setComputers:)]) {
        if ([segue.identifier isEqualToString:@"Desktop"]) {
            NSArray *desktopComputers = @[@"Mac Plus", @"Bondi iMac", @"iMac Flat Panel", @"Mac Pro", @"Mac Mini", @"iMac Aluminium"];
            destination.computers = desktopComputers;
        }else{
            NSArray *portableComputers = @[@"PowerBook 100", @"PowerBook Duo", @"PowerBook G4", @"White MacBook", @"MacBook 13", @"MacBook Air"];
            destination.computers = portableComputers;
        }
    }
}

@end
