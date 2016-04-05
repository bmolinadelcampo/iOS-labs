//
//  ViewController.m
//  Gesture Recogniser Drag
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
    UIPanGestureRecognizer *panRecogniser = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveObject:)];
    panRecogniser.minimumNumberOfTouches = 1;
    [self.cardImage addGestureRecognizer:panRecogniser];
}

- (IBAction)moveObject:(UIPanGestureRecognizer *)sender
{
    self.cardImage.center = [sender locationInView:_cardImage.superview];
}

@end
