//
//  iDCCreateTaskViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCCreateTaskViewController.h"
#import "Task.h"
#import "iDCAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@interface iDCCreateTaskViewController ()

@end

@implementation iDCCreateTaskViewController

- (iDCAppDelegate *)appDelegate {
    return (iDCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.taskTitle.delegate = self;
  self.taskDetail.delegate = self;
	// Do any additional setup after loading the view.
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
  //set uitextview boarder
  self.taskDetail.layer.borderWidth = 1.0f;
  self.taskDetail.layer.borderColor = [[UIColor blackColor] CGColor];
  //set date picker
  self.dueDate.userInteractionEnabled = YES;
  UITapGestureRecognizer *tapGesture =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createDatePicker)];
  [self.dueDate addGestureRecognizer:tapGesture];
  

}

- (void)labelTap
{
  NSLog(@"tapped");
}

- (void) createDatePicker
{
  //  testing date picker
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];
  
  [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
  
  CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
  
  UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
  pickerView.showsSelectionIndicator = YES;
  pickerView.dataSource = self;
  pickerView.delegate = self;
  
  [actionSheet addSubview:pickerView];
  
  UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
  closeButton.momentary = YES;
  closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
  closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
  closeButton.tintColor = [UIColor blackColor];
  [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
  [actionSheet addSubview:closeButton];
  
  [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
  
  [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}


- (IBAction)createTask:(UIBarButtonItem *)sender {

    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext: self.managedObjectContext];

    NSString *taskTitle = self.taskTitle.text;
    NSString *taskDetail = self.taskDetail.text;
    
    NSLog(@"taskTitle:%@, taskDetail:%@",taskTitle, taskDetail);
    [newManagedObject setValue:taskTitle forKey:@"title"];
    [newManagedObject setValue:taskDetail forKey:@"detail"];
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];

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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

#pragma mark -
#pragma mark UITextViewDelegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text{
	if (range.length==0) {
		if ([text isEqualToString:@"\n"]) {
			[textView resignFirstResponder];
			return NO;
		}
	}
	
  return YES;
  
}
#pragma mark UIPickerView

 - (void)dismissActionSheet:(UISegmentedControl*)sender
{
   UIActionSheet *actionSheet = (UIActionSheet *)[sender superview]; [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
 }

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  return 1;
}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//  return
//}

@end
