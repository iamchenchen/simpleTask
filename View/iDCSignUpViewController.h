//
//  iDCSignUpViewController.h
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMob.h"

@interface iDCSignUpViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) UITextField *userRegisterTextField;

@property (nonatomic, strong) UITextField *passwordRegisterTextField;

@property (nonatomic, strong) UITableView *loginTableView;

@property (nonatomic, strong) IBOutlet UIButton *signupButton;

-(IBAction)signUpUserPressed:(id)sender;

@end
