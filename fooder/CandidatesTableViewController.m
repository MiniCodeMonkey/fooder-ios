//
//  CandidatesTableViewController.m
//  fooder
//
//  Created by Mathias Hansen on 3/24/15.
//  Copyright (c) 2015 engage. All rights reserved.
//

#import "CandidatesTableViewController.h"
#import "Candidate.h"

@interface CandidatesTableViewController ()

@end

@implementation CandidatesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"What do you feel like today?";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandidateCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CandidateCell"];
    }

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
