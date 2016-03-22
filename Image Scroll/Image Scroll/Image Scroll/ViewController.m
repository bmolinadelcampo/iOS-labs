//
//  ViewController.m
//  Image Scroll
//
//  Created by Belén Molina del Campo on 22/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    UIImage *myImage = [UIImage imageNamed:@"cowboys_aliens.png"];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:myImage];
    [myImageView setTag:100];
    [self.myScrollView addSubview:myImageView];
    [self.myScrollView setContentSize:CGSizeMake(myImageView.frame.size.width, myImageView.frame.size.height)];
    
    [self.myScrollView setDelegate:self];
    
    [self.myScrollView setMinimumZoomScale:0.5];
    [self.myScrollView setMaximumZoomScale:5];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"X = %0.2f, Y = %0.2f", _myScrollView.contentOffset.x, _myScrollView.contentOffset.y);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:100];
}

@end