//
//  User.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@class Task;

@interface User : SMUserManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
