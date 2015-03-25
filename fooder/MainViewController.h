//
//  ViewController.h
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Directions.h"
#import "CandidatesTableViewController.h"

@interface MainViewController : UIViewController <UITextFieldDelegate> {
    Route *routeResponse;
    CandidatesTableViewController *candidatesTableViewController;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

