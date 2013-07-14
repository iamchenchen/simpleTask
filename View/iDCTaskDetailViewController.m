//
//  iDCTaskDetailViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCTaskDetailViewController.h"
#import "Task.h"

@interface iDCTaskDetailViewController ()

@end

@implementation iDCTaskDetailViewController

@synthesize task;

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  NSLog(@"title is %@", task.title);
  NSLog(@"detail is %@", task.detail);
  [self.taskTitle setText: task.title];
  [self.taskDetail setText: task.detail];
}

@end
