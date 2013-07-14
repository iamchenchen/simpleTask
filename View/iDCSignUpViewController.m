//
//  iDCSignUpViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCSignUpViewController.h"
#import "User.h"
#import "ADVTheme.h"
#import "iDCAppDelegate.h"

@interface iDCSignUpViewController ()

@end

@implementation iDCSignUpViewController

- (iDCAppDelegate *)appDelegate {
  return (iDCAppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
  id <ADVTheme> theme = [ADVThemeManager sharedTheme];
  
  
//  self.title = @"Login";
  
  self.loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 50, 294, 110) style:UITableViewStyleGrouped];
  
  [self.loginTableView setScrollEnabled:NO];
  [self.loginTableView setBackgroundView:nil];
  [self.view addSubview:self.loginTableView];
  
  [self.loginTableView setDataSource:self];
  [self.loginTableView setDelegate:self];
  
  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
  
  
  [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
  [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
  
  
  
  self.userRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
  [self.userRegisterTextField setPlaceholder:@"Username"];
  [self.userRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  
  
  self.passwordRegisterTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
  [self.passwordRegisterTextField setPlaceholder:@"Password"];
  [self.passwordRegisterTextField setSecureTextEntry:YES];
  [self.passwordRegisterTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  
  self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
  
  self.userRegisterTextField.delegate = self;
  self.passwordRegisterTextField.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.row == 0){
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.userRegisterTextField];
    
  }else {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.passwordRegisterTextField];
  }
  
  return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

#pragma mark IB Actions

////Sign Up Button pressed
-(IBAction)signUpUserPressed:(id)sender
{
  User *newUser = [[User alloc] initIntoManagedObjectContext:self.managedObjectContext];
  
  [newUser setValue:self.userRegisterTextField.text forKey:[newUser primaryKeyField]];
  [newUser setPassword:self.passwordRegisterTextField.text];
  
  [self.managedObjectContext saveOnSuccess:^{
    //      alter create successful
    [self.navigationController popViewControllerAnimated:YES];
  } onFailure:^(NSError *error) {
    //Something bad has ocurred
    NSString *errorString = [error localizedDescription];
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
  }];
}


@end
