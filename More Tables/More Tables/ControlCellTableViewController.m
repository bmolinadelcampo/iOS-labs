//
//  ControlCellTableViewController.m
//  More Tables
//
//  Created by Belén Molina del Campo on 30/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ControlCellTableViewController.h"

@interface ControlCellTableViewController ()
@property (nonatomic, strong) NSArray *myList;

- (IBAction)colourSwitch:(id)sender;
@end

@implementation ControlCellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myList = @[@"Red", @"Green", @"Blue", @"Yellow"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colourCell" forIndexPath:indexPath];
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    cellLabel.text = self.myList[indexPath.row];
    
    return cell;
}

- (IBAction)colourSwitch:(id)sender {
    UISwitch *selectedSwitch = (UISwitch *)sender;
    CGPoint switchPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:switchPosition];
    UITableViewCell *myCell = [self.tableView cellForRowAtIndexPath:indexPath];
    switch ([indexPath row]) {
        case 0:
            if (selectedSwitch.isOn) {
                [myCell setBackgroundColor:[UIColor redColor]];
            }else{
                [myCell setBackgroundColor:[UIColor clearColor]];
            }
            break;
        case 1:
            if (selectedSwitch.isOn) {
                [myCell setBackgroundColor:[UIColor greenColor]];
            }else{
                [myCell setBackgroundColor:[UIColor clearColor]];
            }
            break;
        case 2:
            if (selectedSwitch.isOn) {
                [myCell setBackgroundColor:[UIColor blueColor]];
            }else{
                [myCell setBackgroundColor:[UIColor clearColor]];
            }
            break;
        case 3:
            if (selectedSwitch.isOn) {
                [myCell setBackgroundColor:[UIColor yellowColor]];
            }else{
                [myCell setBackgroundColor:[UIColor clearColor]];
            }
            break;
    }
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}
@end
