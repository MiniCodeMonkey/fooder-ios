//
//  Route.h
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Candidate.h"

@interface Route : NSObject {
    NSArray *_candidates;
    NSArray *_route;
}

@property (nonatomic, retain) NSArray *candidates;
@property (nonatomic, retain) NSArray *route;

- (id)initWithDictionary:(NSDictionary*) dict;

@end
