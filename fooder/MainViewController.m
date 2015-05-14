//
//  ViewController.m
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import "MainViewController.h"
#import "CandidatesTableViewController.h"
#import "Directions.h"

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
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    NSDictionary *credentials = [NSDictionary dictionaryWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Credentials" ofType:@"plist"]];
    NSDictionary *uberCredentials = [credentials objectForKey:@"Uber"];
    
    uberKit = [[UberKit alloc] initWithClientID:[uberCredentials objectForKey:@"ClientId"] ClientSecret:[uberCredentials objectForKey:@"ClientSecret"] RedirectURL:[uberCredentials objectForKey:@"RedirectUrl"] ApplicationName:[uberCredentials objectForKey:@"ApplicationName"]];
    uberKit.delegate = self;
    NSString *token = [[UberKit sharedInstance] getStoredAuthToken];
    
    if (!token) {
        [uberKit startLogin];
    }
}

- (void) uberKit: (UberKit *) uberKit didReceiveAccessToken: (NSString *) accessToken {
    NSLog(@"Received access token %@", accessToken);
}

- (void) uberKit: (UberKit *) uberKit loginFailedWithError: (NSError *) error {
    NSLog(@"Error in login %@", error);
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
    
    [Directions directionsForOrigin:@"814 King St., Alexandria VA" destination:self.destinationTextField.text completionHandler:^(BOOL success, Route *route, NSError *error) {
        dispatch_async( dispatch_get_main_queue(), ^{
            if (success) {
                UINavigationController *directionsNavigationController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"DirectionsNavigationController"];
                
                CandidatesTableViewController *candidatesTableViewController = (CandidatesTableViewController*)[directionsNavigationController.viewControllers firstObject];
                candidatesTableViewController.route = route;
                
                [self presentViewController:directionsNavigationController animated:YES completion:^{
                    [self revertLoadingScreen];
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
