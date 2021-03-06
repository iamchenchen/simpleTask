//
//  Task.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/14/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * createddate;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * dueDate;
@property (nonatomic, retain) NSString * hourToFinish;
@property (nonatomic, retain) NSNumber * lastmoddate;
@property (nonatomic, retain) NSString * taskId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * importance;
@property (nonatomic, retain) User *whoOwn;

@end
