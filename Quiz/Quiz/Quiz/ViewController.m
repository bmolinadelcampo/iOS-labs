//
//  ViewController.m
//  Quiz
//
//  Created by Belén Molina del Campo on 16/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property NSInteger currentQuestionIndex;
@property (strong, nonatomic) NSMutableArray *questions;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerALabel;
@property (weak, nonatomic) IBOutlet UILabel *answerBLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerCLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerDLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)answerButton:(id)sender;
- (IBAction)nextButton:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questions = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self.questions addObject:@[@"What is 7 + 7?", @"14", @"15", @"16", @"17", @"A"]];
    [self.questions addObject:@[@"What is the capital of Spain", @"London", @"Paris", @"Munich", @"Madrid", @"D"]];
    [self.questions addObject:@[@"From what is cider made?", @"Oranges", @"Apples", @"Grapes", @"Cherries", @"B"]];
    
    self.currentQuestionIndex = 0;
    
    NSArray *currentQuestionSet = self.questions[self.currentQuestionIndex];
    
    self.questionLabel.text = currentQuestionSet[0];
    self.answerALabel.text = currentQuestionSet[1];
    self.answerBLabel.text = currentQuestionSet[2];
    self.answerCLabel.text = currentQuestionSet[3];
    self.answerDLabel.text = currentQuestionSet[4];
    self.resultLabel.text = @"";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)answerButton:(id)sender {
    NSString *title = [sender titleForState:UIControlStateNormal];
    
    NSArray *currentQuestionSet = self.questions[self.currentQuestionIndex];
    if ([title isEqualToString:currentQuestionSet[5]]) {
        self.resultLabel.text = @"Correct!";
        self.resultLabel.textColor = [UIColor greenColor];
    } else {
        self.resultLabel.text = @"Sorry! Wrong answer";
        self.resultLabel.textColor = [UIColor redColor];
    }
}

- (IBAction)nextButton:(id)sender {
    if (self.currentQuestionIndex < [self.questions count] - 1) {
        self.currentQuestionIndex++;
    } else {
        self.currentQuestionIndex = 0;
    }
    
    NSArray *currentQuestionSet = self.questions[self.currentQuestionIndex];
    
    self.questionLabel.text = currentQuestionSet[0];
    self.answerALabel.text = currentQuestionSet[1];
    self.answerBLabel.text = currentQuestionSet[2];
    self.answerCLabel.text = currentQuestionSet[3];
    self.answerDLabel.text = currentQuestionSet[4];
    self.resultLabel.text = @"";
}
@end
