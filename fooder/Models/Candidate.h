//
//  Candidate.h
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface Candidate : NSObject {
    NSNumber *_score;
    NSString *_name;
    NSString *_distance;
    CLLocationCoordinate2D _location;
}

@property (nonatomic, retain) NSNumber *score;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *distance;
@property (readonly) CLLocationCoordinate2D location;

- (id)initWithDictionary:(NSDictionary*) dict;

@end
