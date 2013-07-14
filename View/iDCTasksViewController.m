//
//  iDCTasksViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCTasksViewController.h"
#import "iDCAppDelegate.h"
#import "iDCTaskListViewController.h"

@interface iDCTasksViewController ()

@end

@implementation iDCTasksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)logout:(id)sender {
  [iDCAppDelegate logout];
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"toList"]) {
    // Get destination view
    iDCTaskListViewController *vc = [segue destinationViewController];
    // Get button tag number (or do whatever you need to do here, based on your object
    NSInteger tagIndex = [sender tag];
    // Pass the information to your destination view
    [vc setSelectedButton:tagIndex];
  }
}

- (IBAction)toList:(UIButton *)sender {
    [self performSegueWithIdentifier:@"toList" sender:sender];
}

@end
