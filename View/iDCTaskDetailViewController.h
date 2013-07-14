//
//  iDCTaskDetailViewController.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;
@interface iDCTaskDetailViewController : UIViewController

@property (strong, nonatomic) Task *task;
@property (weak, nonatomic) IBOutlet UILabel *taskTitle;
@property (weak, nonatomic) IBOutlet UILabel *taskDetail;

@end
