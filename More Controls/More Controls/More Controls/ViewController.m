//
//  ViewController.m
//  More Controls
//
//  Created by Belén Molina del Campo on 17/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepperValueLabel;

- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)sliderChanged:(id)sender;
- (IBAction)switchChanged:(id)sender;
- (IBAction)toggleBackground:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)sliderChanged:(id)sender {
    UISlider *mySlider = (UISlider *)sender;
    NSString *textToDisplay = [NSString stringWithFormat:@"Slider value is: %.0f", mySlider.value];
    self.sliderLabel.text = textToDisplay;
}

- (IBAction)switchChanged:(id)sender {
    UISwitch *mySwitch = sender;
    if (mySwitch.isOn) {
        self.switchLabel.text = @"Switch is On";
    } else {
        self.switchLabel.text = @"Switch is Off";
    }
}

- (IBAction)toggleBackground:(id)sender {
    if ([sender selectedSegmentIndex]== 0) {
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (IBAction)stepperValueChanged:(id)sender {
    UIStepper *myStepper = sender;
    self.stepperValueLabel.text = [NSString stringWithFormat:@"Stepper value is: %.0f", myStepper.value];
}
@end
