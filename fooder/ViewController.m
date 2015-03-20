//
//  ViewController.m
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import "ViewController.h"

#import <GoogleMaps/GoogleMaps.h>
#import "Directions.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.90041
                                                            longitude:-76.999028
                                                                 zoom:11];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.90041, -76.999028);
    marker.title = @"Washington DC";
    marker.snippet = @"Current location";
    marker.map = self.mapView;
    
    marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(38.8050895, -77.0472182);
    marker.title = @"Washington DC";
    marker.snippet = @"Destination";
    marker.map = self.mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {self
    [self.overlayView setHidden:YES];
    
    [Directions directionsForOrigin:@"508 H St NE, Washington DC" destination:@"700 King St., Alexandria VA" completionHandler:^(BOOL success, NSDictionary *response, NSError *error) {
        if (success) {
            dispatch_async( dispatch_get_main_queue(), ^{
                // Draw route
                for (NSArray *step in [response objectForKey:@"route"]) {
                    GMSMutablePath *path = [GMSMutablePath path];
                    for (NSArray *point in step) {
                        [path addCoordinate:CLLocationCoordinate2DMake([[point objectAtIndex:0] doubleValue], [[point objectAtIndex:1] doubleValue])];
                    }
                    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                    polyline.strokeWidth = 3.0f;
                    polyline.strokeColor = [UIColor blackColor];
                    polyline.map = self.mapView;
                }
                
                // Draw candidates
                for (NSDictionary *place in [response objectForKey:@"candidates"]) {
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake([[place valueForKeyPath:@"place.geometry.location.lat"] doubleValue], [[place valueForKeyPath:@"place.geometry.location.lng"] doubleValue]);
                    marker.icon = [UIImage imageNamed:@"burger.png"];
                    marker.title = [place valueForKeyPath:@"place.name"];
                    marker.snippet = [NSString stringWithFormat:@"Score: %.4f", [[place objectForKey:@"score"] doubleValue]];
                    marker.map = self.mapView;
                }
            });
        }
    }];
    
    [self.destinationTextField resignFirstResponder];
    return YES;
}

@end
