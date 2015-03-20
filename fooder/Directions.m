//
//  Directions.m
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import "Directions.h"

@implementation Directions

+ (void)directionsForOrigin:(NSString*)origin destination:(NSString*)destination completionHandler:(DirectionsCompletionBlock)completionHandler {
    NSString *url = [NSString stringWithFormat:@"http://fooder.local/route?origin=%@&destination=%@", [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [destination stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", url);
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error == nil) {
            NSError *error;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            completionHandler(true, response, error);
        } else {
            completionHandler(false, nil, error);
        }
    }];
    
    
}

@end
