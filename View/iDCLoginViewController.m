//
//  iDCLoginViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCLoginViewController.h"
#import "ADVTheme.h"
#import "iDCAppDelegate.h"
#import "StackMob.h"
#import "iDCSignUpViewController.h"


@interface iDCLoginViewController ()

@end

@implementation iDCLoginViewController

@synthesize userTextField = _userTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize client = _client;


- (iDCAppDelegate *)appDelegate {
  return (iDCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  id <ADVTheme> theme = [ADVThemeManager sharedTheme];
  
  
  self.title = @"Login";
  
  self.loginTableView = [[UITableView alloc] initWithFrame:CGRectMake(16, 50, 294, 110) style:UITableViewStyleGrouped];
  
  [self.loginTableView setScrollEnabled:NO];
  [self.loginTableView setBackgroundView:nil];
  [self.view addSubview:self.loginTableView];
  
  [self.loginTableView setDataSource:self];
  [self.loginTableView setDelegate:self];
  
  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[theme viewBackground]]];
  
  
  [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
  [self.loginButton setBackgroundImage:[theme colorButtonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
  
  [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateNormal] forState:UIControlStateNormal];
  [self.signupButton setBackgroundImage:[theme buttonBackgroundForState:UIControlStateHighlighted] forState:UIControlStateHighlighted];
  
  
  self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
  [self.userTextField setPlaceholder:@"Username"];
  [self.userTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  
  
  self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 260, 50)];
  [self.passwordTextField setPlaceholder:@"Password"];
  [self.passwordTextField setSecureTextEntry:YES];
  [self.passwordTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
  
  self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
  
  self.client = [SMClient defaultClient];
  
  self.userTextField.delegate = self;
  self.passwordTextField.delegate = self;
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark IB Actions

//Show the hidden register view
//-(IBAction)signUpPressed:(id)sender
//{
//  [self performSegueWithIdentifier:@"signup" sender:self];
//}

//Login button pressed
-(IBAction)logInPressed:(id)sender
{
  [self.client loginWithUsername:self.userTextField.text password:self.passwordTextField.text onSuccess:^(NSDictionary *results) {
    
    if ([self.client isLoggedIn]) {
      NSLog(@"Logged in");
    }
    
    [self performSegueWithIdentifier:@"afterSignIn" sender:self];
    
  } onFailure:^(NSError *error) {
    //Something bad has ocurred
    NSString *errorString = [error localizedDescription];
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [errorAlertView show];
  }];
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell* cell = nil;
  
  if(indexPath.row == 0){
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UsernameCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.userTextField];
    
  }else {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PasswordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.passwordTextField];
  }
  
  return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}


@end
