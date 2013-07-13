//
//  iDCAppDelegate.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCAppDelegate.h"
#import "StackMob.h"
//Theme...
#import "ADVTheme.h"

#define STACK_MOB_DEV_PUBLIC_KEY @"e92699ac-7895-4fcd-8e04-a94e9f45e4f8"
#define STACK_MOB_PRD_PUBLIC_KEY @"28e0d803-dea0-40fc-bdac-1b820d4d5483"

@interface iDCAppDelegate ()

@property (strong, nonatomic) SMClient *client;
@end

@implementation iDCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [ADVThemeManager customizeAppAppearance];
  
  self.client = [[SMClient alloc] initWithAPIVersion:@"0" publicKey:STACK_MOB_DEV_PUBLIC_KEY];
  self.coreDataStore = [self.client coreDataStoreWithManagedObjectModel:self.managedObjectModel];
  
  return YES;
}

- (NSManagedObjectModel *)managedObjectModel
{
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }  
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"simpleTaskData" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
