//
//  ViewController.m
//  Simple Table
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listData = @[@"Mac Plus", @"Bondi iMac", @"iMac Flat Panel", @"Mac Pro", @"Mac Mini", @"iMac Aluminium", @"PowerBook 100", @"PowerBook G4", @"White MacBook", @"MacBook 13", @"MacBook Air"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *myTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTableIdentifier forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    cell.textLabel.text = self.listData[row];
    
    NSString *imageName = self.listData[row];
    NSString *fullImageName = [imageName stringByAppendingString:@".png"];
    UIImage *image = [UIImage imageNamed:fullImageName];
    cell.imageView.image = image;
    
    if (row < 6) {
        cell.detailTextLabel.text = @"Desktop";
    }else{
        cell.detailTextLabel.text = @"Portable";
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    if (row < 6) {
        return nil;
    }else{
        return indexPath;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSString *rowValue = self.listData[row];
    NSString *message = [NSString stringWithFormat:@"You selected %@", rowValue];
    
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Row Selected" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"OK was pressed");
    }];
    [myAlert addAction:ok];
    [self presentViewController:myAlert animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 70;
}

@end
