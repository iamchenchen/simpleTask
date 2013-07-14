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

- (void) goToList:(NSNumber *) priority{
    NSLog(@"Value Clicked: %@",priority);

    iDCTaskListViewController *targetController=[[iDCTaskListViewController alloc]init];
    targetController.priority=priority;
    [self.navigationController pushViewController:targetController animated:YES];    
}

- (IBAction)smallTaskAction:(UIButton *)sender {
    [self goToList:[NSNumber numberWithInt:SMALL_TASK]];
}

- (IBAction)mediumTaskAction:(UIButton *)sender {
    [self goToList:[NSNumber numberWithInt:MEDIUM_TASK]];
    
}

- (IBAction)bigTaskAction:(UIButton *)sender {
    [self goToList:[NSNumber numberWithInt:BIG_TASK]];
}
@end
