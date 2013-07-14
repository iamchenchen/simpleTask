//
//  iDCTaskListViewController.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SMALL_TASK 3
#define MEDIUM_TASK  2
#define BIG_TASK  1

@interface iDCTaskListViewController : UITableViewController
@property(nonatomic) NSNumber *priority;

@end
