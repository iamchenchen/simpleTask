//
//  iDCCreateTaskViewController.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iDCCreateTaskViewController : UIViewController

- (IBAction)createTask:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *taskTitle;

@property (weak, nonatomic) IBOutlet UITextField *details;

@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;



@end
