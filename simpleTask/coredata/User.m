//
//  User.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "User.h"
#import "Task.h"


@implementation User

@dynamic username;
@dynamic tasks;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
  self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
  
  if (self) {
    // assign local variables and do other init stuff here
  }
  
  return self;
}

@end
