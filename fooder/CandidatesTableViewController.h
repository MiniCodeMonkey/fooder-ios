//
//  CandidatesTableViewController.h
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "Route.h"

@interface CandidatesTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) Route *route;
@property (nonatomic, retain) NSArray *items;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
