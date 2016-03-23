//
//  ViewController.m
//  Sections and Indexes
//
//  Created by Belén Molina del Campo on 23/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) NSDictionary *names;
@property(nonatomic, strong) NSArray *keys;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"sortednames" withExtension:@"plist"];
    self.names = [[NSDictionary alloc] initWithContentsOfURL:path];
    NSArray *myArray = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.keys = myArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    NSArray *nameSection = [self.names objectForKey:key];
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    NSString *key = self.keys[section];
    NSArray *nameSection = [self.names objectForKey:key];
    static NSString *myTableIdentifier = @"sectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myTableIdentifier forIndexPath:indexPath];
    cell.textLabel.text = nameSection[row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    return key;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}

@end
