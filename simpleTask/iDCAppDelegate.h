//
//  iDCAppDelegate.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"


@class SMClient;
@class SMCoreDataStore;

@interface iDCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;

//MBProgressHUD
@property (nonatomic, strong) MBProgressHUD *hud;

/// Returns instance of app delegate (ICanWeightAppDelegate instance).
/// @returns WeightTrackerAppDelegate instance.
+ (iDCAppDelegate *)instance;

+ (void)showProgressView;
+ (void)hideProgressView;
+ (void)hideProgressViewWithComplete: (NSString *)message;
+ (void)showCompleteView:(NSString *) message;

@end
