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
@property (nonatomic, strong) UIDatePicker *datePicker;
//@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSArray *hourList;
@property (nonatomic, strong) NSArray *minuteList;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *mins;
@property (nonatomic, strong) NSNumber *impt;
@end

@implementation iDCCreateTaskViewController

//@synthesize dateFormatter;

- (iDCAppDelegate *)appDelegate {
    return (iDCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  //  set duedate today
  self.hour = @"0 hour";
  self.mins = @"0 minute";
  self.hourList = [[NSArray alloc] initWithObjects:@"0 hour", @"1 hour", @"2 hours",@"3 hours",@"4 hours",@"5 hours",@"6 hours",@"7 hours",@"8 hours",@"9 hours",@"10 hours", @"11 hours",@"12 hours",@"13 hours",@"14 hours",@"15 hours",@"16 hours",@"17 hours",@"18 hours",@"19 hours",@"20 hours",@"21 hours",@"22 hours",@"23 hours",@"24 hours", nil];
  self.minuteList = [[NSArray alloc] initWithObjects:@"0 minute",@"15 minutes",@"30 minutes",@"45 minutes", nil];
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//  [self.dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//  [dateFormatter setDateFormat:@"dd.MM.YY"];
  [self.dueDate setText:[dateFormatter stringFromDate:[NSDate date]]];
  
  self.taskTitle.delegate = self;
  self.taskDetail.delegate = self;
	// Do any additional setup after loading the view.
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
  //set uitextview boarder
  self.taskDetail.layer.borderWidth = 1.0f;
  self.taskDetail.layer.borderColor = [[UIColor blackColor] CGColor];
  //set date picker
  self.dueDate.userInteractionEnabled = YES;
  self.hours.userInteractionEnabled = YES;
  UITapGestureRecognizer *tapGesture =
  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createDatePicker)];
  [self.dueDate addGestureRecognizer:tapGesture];
  tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createHourPicker)];
  [self.hours addGestureRecognizer:tapGesture];
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
  
//  UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
//  pickerView.showsSelectionIndicator = YES;
//  pickerView.dataSource = self;
//  pickerView.delegate = self;
  
//  [actionSheet addSubview:pickerView];
  
  if(self.datePicker == nil) self.datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
  [self.datePicker setMinimumDate:[NSDate date]];
  [self.datePicker setDatePickerMode:UIDatePickerModeDate];
  [self.datePicker setHidden:NO];
  [self.datePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
  [actionSheet addSubview:self.datePicker];
  
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

- (void) createHourPicker
{
  NSLog(@"called");
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
  
//  if(self.datePicker == nil) self.datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
//  [self.datePicker setMinimumDate:[NSDate date]];
//  [self.datePicker setDatePickerMode:UIDatePickerModeDate];
//  [self.datePicker setHidden:NO];
//  [self.datePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
//  [actionSheet addSubview:self.datePicker];
  
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


-(void)pickerValueChanged:(UIDatePicker *)picker{
  NSLog(@"blah %@", self.datePicker.date.description); // set text to date description
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
  [self.dueDate setText: [dateFormatter stringFromDate: self.datePicker.date]];
}

- (IBAction)createTask:(UIBarButtonItem *)sender {

    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext: self.managedObjectContext];

    NSString *taskTitle = self.taskTitle.text;
    NSString *taskDetail = self.taskDetail.text;
    //NSDate *lastDate = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *dueDate = [dateFormatter stringFromDate:self.datePicker.date];
    //NSNumber self.hour
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    //NSString *time = (self.hour? self.hour+@"hr:":null)+(self.mins? self.mins+@"mm":null);
    NSString *sHr,*sMin;
    if (!self.hour){
        sHr = [NSString stringWithFormat:@"%@hr",self.hour];
    }else if(!self.mins){
        sMin = [NSString stringWithFormat:@"%@mm",self.mins];
    }
    //NSString *sHr = [NSString stringWithFormat:@"%@hr",];
    //NSNumber *nHour = [f numberFromString:self.hour];
    //NSNumber *nMin = [f numberFromString:self.mins];
    //NSNumber *totalMiliSec
    //= [NSNumber numberWithInt:([nHour intValue]*60*60*1000 + [nMin intValue]*60*1000)];
    NSNumber *heat = [NSNumber numberWithInt:(self.importance.selectedSegmentIndex+1)];
    
    NSLog(@"taskTitle:%@, totalMiliSec:%@ lastDate:%@ importance:%@",taskTitle, sHr, dueDate, heat);
    [newManagedObject setValue:taskTitle forKey:@"title"];
    [newManagedObject setValue:taskDetail forKey:@"detail"];
    [newManagedObject setValue:dueDate forKey:@"dueDate"];
    [newManagedObject setValue:sHr  forKey:@"hourToFinish"];
    [newManagedObject setValue:heat forKey:@"importance"];
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

 - (void)dismissActionSheet:(UIActionSheet *)sender
{
//  NSLog(@"%@", (UIDatePicker *)[sender date]);
   UIActionSheet *actionSheet = (UIActionSheet *)[sender superview]; [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
 }

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  if (component == 0) {
    return [self.hourList count];
  }
  return [self.minuteList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
  if (component == 0) {
    return [self.hourList objectAtIndex:row];

  }
  return [self.minuteList objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
  NSLog(@"called");
  if (component == 0) {
    self.hour = [NSString stringWithFormat:@"%@",[self.hourList objectAtIndex:row]];
  } else {
    self.mins = [NSString stringWithFormat:@"%@",[self.minuteList objectAtIndex:row]];
  }
  NSString *result = [NSString stringWithFormat:@"%@ %@", self.hour, self.mins];
  [self.hours setText: result];
}




@end
