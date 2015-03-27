//
//  Candidate.m
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import "Candidate.h"

@implementation Candidate

@synthesize score = _score;
@synthesize name = _name;
@synthesize distance = _distance;
@synthesize location = _location;

- (id)initWithDictionary:(NSDictionary*) dict {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Keep it simple for now
    _score = [dict objectForKey:@"score"];
    _name = [dict valueForKeyPath:@"place.name"];
    _distance = [dict objectForKey:@"distance"];
    _location = CLLocationCoordinate2DMake([[dict valueForKeyPath:@"place.geometry.location.lat"] doubleValue], [[dict valueForKeyPath:@"place.geometry.location.lng"] doubleValue]);
    
    return self;
}

@end
