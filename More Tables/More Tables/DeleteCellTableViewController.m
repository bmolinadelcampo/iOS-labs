//
//  DeleteCellTableViewController.m
//  More Tables
//
//  Created by Belén Molina del Campo on 30/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "DeleteCellTableViewController.h"

@interface DeleteCellTableViewController ()
@property (nonatomic, strong) NSMutableArray *myList;
- (IBAction)toggleEdit:(id)sender;
@end

@implementation DeleteCellTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"computers" ofType:@"plist"];
    self.myList = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.myList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deleteCell"  forIndexPath:indexPath];
    
    cell.textLabel.text = self.myList[indexPath.row];
    
    return cell;
}

- (IBAction)toggleEdit:(id)sender
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"Delete"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.myList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

@end