//
//  Directions.h
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface Directions : NSObject

typedef void (^DirectionsCompletionBlock)(BOOL success, Route *route, NSError *error);

+ (void)directionsForOrigin:(NSString*)origin destination:(NSString*)destination completionHandler:(DirectionsCompletionBlock)completionHandler;

@end
