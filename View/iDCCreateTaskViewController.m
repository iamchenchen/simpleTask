//
//  iDCCreateTaskViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCCreateTaskViewController.h"
#import "Task.h"
#import "iDCAppDelegate.h"


@interface iDCCreateTaskViewController ()

@end

@implementation iDCCreateTaskViewController

- (iDCAppDelegate *)appDelegate {
    return (iDCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
}

- (IBAction)createTask:(UIBarButtonItem *)sender {

    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Task"
                                                                      inManagedObjectContext:self.managedObjectContext];

    NSString *taskTitle = self.taskTitle.text;
    NSString *taskDetail = self.details.text;
    
    NSLog(@"taskTitle:%@, taskDetail:%@",taskTitle, taskDetail);
    //  NSDate *now = [NSDate date];
    //    [newManagedObject setValue:now forKey:@"createddate"];
    //    [newManagedObject setValue:now forKey:@"lastmoddate"];
    [newManagedObject setValue:taskTitle forKey:@"title"];
    [newManagedObject setValue:taskDetail forKey:@"detail"];
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject
                                                                         primaryKeyField]];
    
    [self.managedObjectContext saveOnSuccess:^{
        //      alter create successful
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *error) {
        //Something bad has ocurred
        NSString *errorString = [error localizedDescription];
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
    }];
    
}

@end
