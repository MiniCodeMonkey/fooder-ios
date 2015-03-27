//
//  CandidatesTableViewController.m
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import "CandidatesTableViewController.h"
#import "Candidate.h"

@interface CandidatesTableViewController ()

@end

@implementation CandidatesTableViewController

@synthesize route;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure table view
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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
        marker.snippet = candidate.distance;
        marker.map = self.mapView;
    }
    
    // Draw start/end
    NSArray *startEnd = [[NSArray alloc] initWithObjects:[[route.route objectAtIndex:0] objectAtIndex:0], [[route.route lastObject] lastObject], nil];
    for (NSArray *position in startEnd) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([[position objectAtIndex:0] doubleValue], [[position objectAtIndex:1] doubleValue]);
        marker.map = self.mapView;
    }
    
    // Update map zoom
    [self.mapView moveCamera:[GMSCameraUpdate fitBounds:bounds]];
    
    // Prepare table view
    [self setCandidates:route.candidates];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCandidates:(NSArray*)candidates {
    NSMutableDictionary *list = [[NSMutableDictionary alloc] init];
    
    for (Candidate *candidate in candidates) {
        if ([list objectForKey:candidate.name] == nil) {
            [list setObject:[[NSMutableArray alloc] init] forKey:candidate.name];
        }
        
        NSMutableArray *arr = [list objectForKey:candidate.name];
        [arr addObject:candidate];
    }
    
    self.items = [list allValues];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandidateCell" forIndexPath:indexPath];
    Candidate *candidate = [[self.items objectAtIndex:[indexPath row]] firstObject];
    cell.textLabel.text = candidate.name;
    cell.detailTextLabel.text = candidate.distance;
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
