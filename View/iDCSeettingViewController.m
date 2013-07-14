//
//  iDCSeettingViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/14/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCSeettingViewController.h"
#import "iDCAppDelegate.h"

@interface iDCSeettingViewController ()

@end

@implementation iDCSeettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)logout:(id)sender {
  [iDCAppDelegate logout];
}
@end
