//
//  AboutViewController.h
//  fooder
//
//  Created by Mathias Hansen on 5/13/15.
//  Copyright (c) 2015 Mathias Hansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)doneButtonClicked:(id)sender;

@end
