//
//  iDCAppDelegate.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCAppDelegate.h"
#import "StackMob.h"

#import "ADVTheme.h" //theme

#import "iDCLoginViewController.h"


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
  [self signInChecker];
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

#pragma mark - MBProgressHUD

/// Returns instance of app delegate (ICanWeightAppDelegate instance).
/// @returns WeightTrackerAppDelegate instance.
+ (iDCAppDelegate *)instance {
	return (iDCAppDelegate *)[UIApplication sharedApplication].delegate;
}


+ (void)showProgressView
{
  iDCAppDelegate *appDelegate = [iDCAppDelegate instance];
  appDelegate.hud = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
  appDelegate.hud.labelText = NSLocalizedString(@"Loading", nil);
  //  [MBProgressHUD showHUDAddedTo:appDelegate.window animated:YES];
  
}

+ (void)hideProgressView
{
  iDCAppDelegate *appDelegate = [iDCAppDelegate instance];
  [appDelegate.hud hide:YES];
  //  [MBProgressHUD hideHUDForView:appDelegate.window animated:YES];
  //  [appDelegate.hud removeFromSuperview];
}

+ (void)hideProgressViewWithComplete: (NSString *)message
{
  iDCAppDelegate *appDelegate = [iDCAppDelegate instance];
  appDelegate.hud.customView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	appDelegate.hud.mode = MBProgressHUDModeCustomView;
	appDelegate.hud.labelText = message;
  //	sleep(1);
  [appDelegate.hud hide:YES afterDelay:1];
}

+ (void)showCompleteView:(NSString *)message
{
  iDCAppDelegate *appDelegate = [iDCAppDelegate instance];
  appDelegate.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
  appDelegate.hud.mode = MBProgressHUDModeCustomView;
	appDelegate.hud.labelText = message;
  [appDelegate.hud show:YES];
	[appDelegate.hud hide:YES afterDelay:1];
}

#pragma mark - private functions

- (void) signInChecker
{
  if([self.client isLoggedIn]) {
    
    [self.client getLoggedInUserOnSuccess:^(NSDictionary *result) {
//      self.statusLabel.text = [NSString stringWithFormat:@"Hello, %@", [result objectForKey:@"username"]];
      NSLog(@"Hello, %@", [result objectForKey:@"username"]);
    } onFailure:^(NSError *error) {
      NSLog(@"No user found");
    }];
    
  } else {
//    self.statusLabel.text = @"Nope, not Logged In";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    iDCLoginViewController *login = (iDCLoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LogInNavigation"];
    self.window.rootViewController = login;
    
  }
}

+ (void) logout
{
  iDCAppDelegate *appDelegate = [iDCAppDelegate instance];
  [appDelegate.client logoutOnSuccess:^(NSDictionary *result) {
    NSLog(@"Success, you are logged out");
    //move to login screen
    [appDelegate signInChecker];
  } onFailure:^(NSError *error) {
    NSLog(@"Logout Fail: %@",error);
  }];
}

@end
