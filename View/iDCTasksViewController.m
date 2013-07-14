//
//  iDCTasksViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCTasksViewController.h"
#import "iDCAppDelegate.h"

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

@end
