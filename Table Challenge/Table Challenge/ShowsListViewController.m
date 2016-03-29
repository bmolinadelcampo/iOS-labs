//
//  ViewController.m
//  Table Challenge
//
//  Created by Belén Molina del Campo on 27/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ShowsListViewController.h"
#import "CharactersListViewController.h"

@interface ShowsListViewController ()
@property (strong, nonatomic) NSDictionary *showsCharacters;
@property (strong, nonatomic) NSArray *shows;
@property (strong, nonatomic) NSArray *backgroundColours;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShowsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shows-characters" ofType:@"plist"];
    self.showsCharacters = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    self.shows =[[self.showsCharacters allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    UIColor *dairyCream = [UIColor colorWithRed:0.91 green:0.82 blue:0.65 alpha:1];
    UIColor *tiara = [UIColor colorWithRed:0.75 green:0.85 blue:0.84 alpha:1];
    UIColor *blackSqueeze = [UIColor colorWithRed:0.96 green:0.98 blue:0.98 alpha:1];
    UIColor *nomad = [UIColor colorWithRed:0.72 green:0.69 blue:0.64 alpha:1];
    UIColor *regentBlue = [UIColor colorWithRed:0.67 green:0.82 blue:0.92 alpha:1];
    UIColor *gothic = [UIColor colorWithRed:0.42 green:0.57 blue:0.61 alpha:1];
    
    self.backgroundColours = @[dairyCream, nomad, tiara, blackSqueeze, regentBlue, gothic];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.shows count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *showCell = [tableView dequeueReusableCellWithIdentifier:@"showCell" forIndexPath:indexPath];
    showCell.textLabel.text = self.shows[indexPath.row];
    showCell.backgroundColor = self.backgroundColours[indexPath.row];
    
    showCell.selectionStyle = UITableViewCellSelectionStyleNone;

    return showCell;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CharactersListViewController *destination = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    destination.selectedShow = self.shows[indexPath.row];
    destination.charactersForSelectedShow = [self.showsCharacters objectForKey:self.shows[indexPath.row]];
    destination.backgroundColour = self.backgroundColours[indexPath.row];
}

@end
