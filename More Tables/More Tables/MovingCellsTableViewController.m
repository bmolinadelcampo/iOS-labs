//
//  MovingCellsTableViewController.m
//  More Tables
//
//  Created by Belén Molina del Campo on 29/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "MovingCellsTableViewController.h"

@interface MovingCellsTableViewController ()
@property (nonatomic, strong) NSMutableArray *myList;
- (IBAction)toggleMove:(id)sender;

@end

@implementation MovingCellsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myList = [@[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J"] mutableCopy];
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMove:)];
    self.navigationItem.rightBarButtonItem = moveButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movableCell" forIndexPath:indexPath];
    cell.textLabel.text = self.myList[indexPath.row];
    cell.showsReorderControl = YES;
    return cell;
}

- (IBAction)toggleMove:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"Move"];
    }
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSUInteger fromRow = fromIndexPath.row;
    NSUInteger toRow = toIndexPath.row;
    
    NSString *objectToMove = self.myList[fromRow];
    [self.myList removeObjectAtIndex:fromRow];
    [self.myList insertObject:objectToMove atIndex:toRow];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end