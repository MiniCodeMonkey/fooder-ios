//
//  ViewController.h
//  fooder
//
//  Created by Mathias Hansen on 3/18/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <UberKit/UberKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate, UberKitDelegate> {
    UberKit *uberKit;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicatorView;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@end

