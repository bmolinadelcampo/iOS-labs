//
//  MapAnnotation.m
//  My Map
//
//  Created by Belén Molina del Campo on 07/04/2016.
//  Copyright © 2016 Belén Molina del Campo. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- initWithPosition: (CLLocationCoordinate2D)coords
{
    if (self = [super init]) {
        self.coordinate = coords;
    }
    return self;
}

@end