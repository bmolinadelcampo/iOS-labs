//
//  ViewController.m
//  Custom cell
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#import "MyUITableViewCell.h"


@interface ViewController ()
@property (nonatomic, strong) NSArray *computers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.computers = @[@"Mac Plus", @"Bondi iMac", @"iMac Flat Panel", @"Mac Pro", @"Mac Mini", @"iMac Aluminium", @"PowerBook 100", @"PowerBook G4", @"White MacBook", @"MacBook 13", @"MacBook Air"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.computers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *myTableIdentifier = @"customCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTableIdentifier forIndexPath:indexPath];
//    NSUInteger row = [indexPath row];
//    UILabel *computerNameLabel = (UILabel *)[cell viewWithTag:1];
//    computerNameLabel.text = self.computers[row];
//    
//    UILabel *modelLabel = (UILabel *)[cell viewWithTag:2];
//    if (row < 6) {
//        modelLabel.text = @"Desktop";
//    }else{
//        modelLabel.text = @"Portable";
//    }
//    
//    NSString *imageName = self.computers[row];
//    NSString *fullImageName = [imageName stringByAppendingString:@".png"];
//    UIImage *myImage = [UIImage imageNamed:fullImageName];
//    
//    UIImageView *computerImageView = (UIImageView *)[cell viewWithTag:3];
//    [computerImageView setImage:myImage];
//    
//    return cell;
    
    static NSString *myTableIdentifier = @"customCell";
    MyUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTableIdentifier forIndexPath:indexPath];
    NSUInteger row = [indexPath row];
    cell.nameLabel.text = self.computers[row];

    if (row < 6) {
        cell.typeLabel.text = @"Desktop";
    }else{
        cell.typeLabel.text = @"Portable";
    }

    NSString *imageName = self.computers[row];
    NSString *fullImageName = [imageName stringByAppendingString:@".png"];
    UIImage *myImage = [UIImage imageNamed:fullImageName];

    [cell.computerImage setImage:myImage];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
