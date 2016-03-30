//
//  CheckMarkTableViewController.m
//  More Tables
//
//  Created by Belén Molina del Campo on 30/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CheckMarkTableViewController.h"

@interface CheckMarkTableViewController ()
@property (nonatomic, strong) NSArray *myList;
@property (nonatomic, strong) NSMutableArray *marks;

@end

@implementation CheckMarkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myList = @[@"Arsenal", @"Aston Villa", @"Burnley", @"Chelsea", @"C Palace", @"Everton", @"Hull", @"Leicester", @"Liverpool", @"Manchester City", @"Manchester United", @"Newcastle", @"Queens Park Rangers", @"Southampton", @"Stoke", @"Sunderland", @"Swansea", @"Spurs", @"West Brom", @"West Ham"];
    
    self.marks = [[NSMutableArray alloc] initWithCapacity:0];
    for (int x = 0; x < [self.myList count]; x++) {
        [self.marks addObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkMarkCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.myList[indexPath.row];
    if ([[self.marks objectAtIndex:indexPath.row] boolValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.marks objectAtIndex:indexPath.row] boolValue]) {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    BOOL currentBool = [[self.marks objectAtIndex:indexPath.row] boolValue];
    self.marks[indexPath.row] = [NSNumber numberWithBool:!currentBool];
}
@end
