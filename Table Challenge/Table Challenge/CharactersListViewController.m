//
//  CharactersListViewController.m
//  Table Challenge
//
//  Created by Belén Molina del Campo on 27/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "CharactersListViewController.h"

@interface CharactersListViewController ()

@end

@implementation CharactersListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.selectedShow;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.charactersForSelectedShow count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *characterCell = [tableView dequeueReusableCellWithIdentifier:@"characterCell" forIndexPath:indexPath];
    characterCell.textLabel.text = self.charactersForSelectedShow[indexPath.row];
    characterCell.backgroundColor = self.backgroundColour;
    
    characterCell.selectionStyle = UITableViewCellSelectionStyleNone;

    return characterCell;
}

@end