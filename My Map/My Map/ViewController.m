//
//  ViewController.m
//  My Map
//
//  Created by Belén Molina del Campo on 07/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "ViewController.h"
#import "MapAnnotation.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myMapView setDelegate:self];
    
    CLLocationCoordinate2D theCoordinate = CLLocationCoordinate2DMake(51.51447145, -0.13511896);
    MKCoordinateRegion myRegion = MKCoordinateRegionMakeWithDistance(theCoordinate, 500, 500);
    [self.myMapView setRegion:myRegion animated:YES];
}


- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D theCoordinate = CLLocationCoordinate2DMake(51.51447145, -0.13511896);
    MapAnnotation *amsys = [[MapAnnotation alloc] initWithPosition:theCoordinate];
    [amsys setCoordinate:theCoordinate];
    [amsys setTitle:@"Amsys Training Centre"];
    [amsys setSubtitle:@"24 Berwick Street, London, W1F 8RE"];
    [self.myMapView addAnnotation:amsys];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pinView = nil;
    static NSString *defaultPinID = @"myPinID";
    pinView = (MKPinAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    [pinView setPinTintColor:[UIColor blueColor]];
    [pinView setCanShowCallout:YES];
    [pinView setAnimatesDrop:YES];
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"d13.png"]];
    myImageView.frame = CGRectMake(0, 0, 25, 25);
    [pinView setLeftCalloutAccessoryView:myImageView];
    [pinView setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.amsys.co.uk"]];
}
@end

