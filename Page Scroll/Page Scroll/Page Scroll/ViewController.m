//
//  ViewController.m
//  Page Scroll
//
//  Created by Belén Molina del Campo on 22/03/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
{
    BOOL pageControlUsed;

}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *myPageControl;

- (IBAction)changePage:(id)sender;
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
        [self.myScrollView setDelegate:self];
        [self.myPageControl setNumberOfPages:kNumImages];
        [self.myPageControl setCurrentPage:0];
    }
    [self.myScrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (pageControlUsed) {
        return;
    }
    CGFloat xOrigin = self.myScrollView.contentOffset.x;
    CGFloat width = self.myScrollView.bounds.size.width;
    self.myPageControl.currentPage = round(xOrigin/width);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    NSInteger page = self.myPageControl.currentPage;
    CGRect frame = self.myScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [self.myScrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

@end
