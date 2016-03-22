//
//  FirstViewController.m
//  Pickers
//
//  Created by Belén Molina del Campo on 22/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerData = @[@"Luke", @"Leia", @"Han", @"Chewbacca", @"Artoo", @"C3PO", @"Yoda"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *character = _pickerData[row];
    NSString *fullImageName = [NSString stringWithFormat:@"%@.jpg", character];
    _myImageView.image = [UIImage imageNamed:fullImageName];
}

@end
