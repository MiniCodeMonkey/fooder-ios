//
//  ViewController.m
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import "MainViewController.h"

#import <GoogleMaps/GoogleMaps.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.90041
                                                            longitude:-76.999028
                                                                 zoom:11];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    
    candidatesTableViewController = [[CandidatesTableViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingScreen {
    [self.destinationTextField setHidden:YES];
    self.titleLabel.text = @"Finding a good route...";
    [self.loadingIndicatorView startAnimating];
}

- (void)revertLoadingScreen {
    [self.destinationTextField setHidden:NO];
    self.titleLabel.text = @"Where do you want to go?";
    [self.loadingIndicatorView stopAnimating];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self showLoadingScreen];
    
    [Directions directionsForOrigin:@"508 H St NE, Washington DC" destination:@"700 King St., Alexandria VA" completionHandler:^(BOOL success, Route *route, NSError *error) {
        dispatch_async( dispatch_get_main_queue(), ^{
            if (success) {
                routeResponse = route;
                
                [self.overlayView setHidden:YES];
                // Keep track of the bounds
                GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
                
                // Draw route
                for (NSArray *step in route.route) {
                    GMSMutablePath *path = [GMSMutablePath path];
                    for (NSArray *point in step) {
                        [path addCoordinate:CLLocationCoordinate2DMake([[point objectAtIndex:0] doubleValue], [[point objectAtIndex:1] doubleValue])];
                    }
                    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
                    polyline.strokeWidth = 3.0f;
                    polyline.strokeColor = [UIColor blackColor];
                    polyline.map = self.mapView;
                    
                    bounds = [bounds includingPath:path];
                }
                
                // Draw candidates
                for (Candidate *candidate in route.candidates) {
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = candidate.location;
                    marker.icon = [UIImage imageNamed:@"burger.png"];
                    marker.title = candidate.name;
                    marker.snippet = [NSString stringWithFormat:@"Score: %.4f", [candidate.score doubleValue]];
                    marker.map = self.mapView;
                }
                
                // Draw start/end
                NSArray *startEnd = [[NSArray alloc] initWithObjects:[[route.route objectAtIndex:0] objectAtIndex:0], [[route.route lastObject] lastObject], nil];
                for (NSArray *position in startEnd) {
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake([[position objectAtIndex:0] doubleValue], [[position objectAtIndex:1] doubleValue]);
                    marker.map = self.mapView;
                }
                
                
                // Show options view
                CGFloat halfHeight = self.view.frame.size.height / 2;
                
                // Prepare table view
                [candidatesTableViewController setCandidates:routeResponse.candidates];
                candidatesTableViewController.view.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, halfHeight);
                [self.view addSubview:candidatesTableViewController.view];
                
                // Animate table view in and map position!
                [UIView animateWithDuration:0.5f animations:^{
                    self.mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, halfHeight);
                    
                    candidatesTableViewController.view.frame = CGRectMake(0, halfHeight, self.view.frame.size.width, halfHeight);
                } completion:^(BOOL finished) {
                    // Update the camera view
                    [self.mapView moveCamera:[GMSCameraUpdate fitBounds:bounds]];
                }];
                
            } else {
                UIAlertController *alertController = [UIAlertController
                                                      alertControllerWithTitle:@"Could not get route"
                                                      message:[error description]
                                                      preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:nil];
                
                [alertController addAction:okAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
                [self revertLoadingScreen];
                
            }
       });
    }];
    
    [self.destinationTextField resignFirstResponder];
    return YES;
}

@end
