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
- (IBAction)showAlert:(id)sender;
- (IBAction)promptForPassword:(id)sender;
- (IBAction)showActionSheet:(id)sender;
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

- (IBAction)showAlert:(id)sender {
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"My Alert" message:@"Some message goes here!" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertViewStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   NSLog(@"Ok button was pressed");
                                               }];
    [myAlert addAction:ok];
    [self presentViewController:myAlert animated:YES completion:nil];
}

- (IBAction)promptForPassword:(id)sender {
    UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Login" message:@"Please enter your name and password" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *name = myAlert.textFields[0];
        UITextField *password = myAlert.textFields[1];
        NSLog(@"Name is %@ and password is %@", name.text, password.text);

    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [myAlert addAction:ok];
    [myAlert addAction:cancel];
    
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Name";
    }];
    
    [myAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Password";
        textField.secureTextEntry = YES;
    }];
    
    [self presentViewController:myAlert animated:YES completion:nil];
}

- (IBAction)showActionSheet:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"My action sheet" message:@"Please make a selection" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *option1 = [UIAlertAction actionWithTitle:@"Option 1" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"Option 1 was tapped");
    }];
    UIAlertAction *option2 = [UIAlertAction actionWithTitle:@"Option 2" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"Option 2 was tapped");
    }];
    UIAlertAction *option3 = [UIAlertAction actionWithTitle:@"Option 3" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action){
        NSLog(@"Option 3 was tapped");
    }];
    
    [actionSheet addAction:option1];
    [actionSheet addAction:option2];
    [actionSheet addAction:option3];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
@end
