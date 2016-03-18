//
//  ViewController.m
//  Four Switches
//
//  Created by Belén Molina del Campo on 17/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@property (weak, nonatomic) IBOutlet UISwitch *switch2;
@property (weak, nonatomic) IBOutlet UISwitch *switch3;
@property (weak, nonatomic) IBOutlet UISwitch *switch4;


- (IBAction)oneSwitchValueChanged:(UISwitch *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)oneSwitchValueChanged:(UISwitch *)sender {
    
    BOOL isOn = sender.isOn;
    
    [self.switch1 setOn:isOn];
    [self.switch2 setOn:isOn];
    [self.switch3 setOn:isOn];
    [self.switch4 setOn:isOn];
}
@end
