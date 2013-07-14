//
//  iDCCreateTaskViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCCreateTaskViewController.h"
#import "Task.h"

@interface iDCCreateTaskViewController ()

@end

@implementation iDCCreateTaskViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)createTask:(UIBarButtonItem *)sender {

    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                                      inManagedObjectContext:self.managedObjectContext];

    NSString *taskTitle = self.taskTitle.text;
    NSString *taskDetail = self.details.text;
    
    NSLog(@"taskTitle:%@, taskDetail:%@",taskTitle, taskDetail);
    
    
}

@end
