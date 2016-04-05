//
//  ViewController.m
//  Gesture Recogniser Rotate
//
//  Created by Belén Molina del Campo on 05/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRotationGestureRecognizer *rotateRecogniser = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateObject:)];
    [self.cardImage addGestureRecognizer: rotateRecogniser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rotateObject:(UIRotationGestureRecognizer *)sender
{
    NSLog(@"Rotating");
    self.cardImage.transform = CGAffineTransformMakeRotation(sender.rotation);
}
@end