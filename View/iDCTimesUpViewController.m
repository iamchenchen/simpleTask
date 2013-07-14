//
//  iDCTimesUpViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/14/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCTimesUpViewController.h"

@interface iDCTimesUpViewController ()

@end

@implementation iDCTimesUpViewController
- (IBAction)back:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
