//
//  ViewController.m
//  Page Scroll
//
//  Created by Belén Molina del Campo on 22/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ViewController

CGFloat kScrollObjHeight = 155;
CGFloat kScrollObjWidth = 300;
NSInteger kNumImages = 8;

- (void)viewDidLoad {
    [super viewDidLoad];
    _myScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _myScrollView.pagingEnabled = YES;
    CGFloat curXLoc = 0;
    
    for (NSInteger i=1; i <= kNumImages; i++) {
        NSString *imageName = [NSString stringWithFormat:@"image%lu.png", (long)i];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect myFrame = imageView.frame;
        myFrame.size.height = kScrollObjHeight;
        myFrame.size.width = kScrollObjWidth;
        myFrame.origin = CGPointMake(curXLoc, 0);
        imageView.frame =myFrame;
        curXLoc += kScrollObjWidth;
        [self.myScrollView addSubview:imageView];
    }
    [self.myScrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
