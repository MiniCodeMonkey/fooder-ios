//
//  CandidatesTableViewController.h
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandidatesTableViewController : UITableViewController

@property (nonatomic, retain) NSArray *items;

- (void)setCandidates:(NSArray*)candidates;

@end
