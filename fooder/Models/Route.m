//
//  Route.m
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import "Route.h"

@implementation Route

@synthesize route = _route;
@synthesize candidates = _candidates;

- (id)initWithDictionary:(NSDictionary*) dict {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    // Keep it simple for now
    _route = [dict objectForKey:@"route"];
    
    // Initialize Candidate objects
    NSMutableArray *candidates = [[NSMutableArray alloc] init];
    
    for (NSDictionary *candidate in [dict objectForKey:@"candidates"]) {
        [candidates addObject:[[Candidate alloc] initWithDictionary:candidate]];;
    }
    
    // Convert to immutable array
    _candidates = [NSArray arrayWithArray:candidates];
    
    return self;
}

@end
