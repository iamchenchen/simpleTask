//
//  iDCTaskListViewController.m
//  simpleTask
//
//  Created by Chenchen Zheng on 7/13/13.
//  Copyright (c) 2013 Chenchen Zheng. All rights reserved.
//

#import "iDCTaskListViewController.h"
#import "StackMob.h"
#import "Task.h"
#import "iDCTaskDetailViewController.h"

@interface iDCTaskListViewController ()
/*
 We define an array to hold the fetched Todo objects.
 */
@property (strong, nonatomic) NSArray *tasks;
@end

@implementation iDCTaskListViewController
@synthesize tasks = _tasks;
@synthesize priority = _priority;

- (void)viewDidLoad
{
  [super viewDidLoad];

  /*
   We initialize our refresh control and assign the refreshTable method to get called when the refresh is initiated. Then we initiate the refresh process.
   */
  UIImage *image = [UIImage imageNamed: @"logo"];
  UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
  
  self.navigationItem.titleView = imageView;
  
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
  self.refreshControl  = refreshControl;
  [refreshControl beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{

    [self refreshTable];
}


/*
 Responsible for fetching all todo objects from StackMob and reloading the table view.
 */
- (void)refreshTable
{
  /*
   The first thing we do is acquire an initialized managed object context from our SMCoreDataStore instance.
   
   Then we create a fetch request for the Todo entity, sorted by the created date.
   
   Finally, we execute the fetch request, assign the results to our objects property, and reload the table data.
   */
  NSManagedObjectContext *context = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createddate" ascending:NO];
  NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
  
  [fetchRequest setSortDescriptors:sortDescriptors];
  
  [context executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
    [self.refreshControl endRefreshing];
    self.tasks = results;
    NSLog(@"task is %@", self.tasks.description);
    [self.tableView reloadData];
    
  } onFailure:^(NSError *error) {
    
    [self.refreshControl endRefreshing];
    NSLog(@"An error %@, %@", error, [error userInfo]);
  }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Task";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
  /*
   We will display the title of the Todo object corresponding to the current row.
   */
  
  Task *task = (Task *)[self.tasks objectAtIndex:indexPath.row];
  UILabel *title = (UILabel *)[cell viewWithTag:100];
  UILabel *day = (UILabel *)[cell viewWithTag:101];
  title.text = task.title;
  day.text = [NSString stringWithFormat:@"%@", task.hourToFinish];
  title.textColor = [UIColor whiteColor];
  day.textColor = [UIColor whiteColor];
  UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 28.0];
  title.font = myFont;
  NSLog(@"task. is %@", task.hourToFinish);
//  cell.textLabel.text = task.title;
//  cell.textLabel.textColor = [UIColor whiteColor];
//  cell.detailTextLabel.textColor = [UIColor whiteColor];
//  UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 28.0 ];
//  cell.textLabel.font  = myFont;

//  cell.detailTextLabel.text = task.hoursToFinish;
//  need to fix

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  Task *task = (Task *)[self.tasks objectAtIndex:indexPath.row];
  if ([task.importance isEqualToNumber:[NSNumber numberWithInt: 1]]) {
    cell.backgroundColor = [self redColor];
  } else if ([task.importance isEqualToNumber:[NSNumber numberWithInt:2]]) {
    cell.backgroundColor = [self yellowColor];
  } else {
    cell.backgroundColor = [self greenColor];
  }
}

- (UIColor *)redColor
{
  return [UIColor colorWithRed:(float)0xe6/255.0 green:(float)0x56/255.0 blue:(float)0x7a/255.0 alpha:1.00f];
}

- (UIColor *)yellowColor
{
  return [UIColor colorWithRed:(float)0xea/255.0 green:(float)0xc1/255.0 blue:(float)0x4d/255.0 alpha:1.00f];
}

- (UIColor *)greenColor
{
  return [UIColor colorWithRed:(float)0x5b/255.0 green:(float)0xd9/255.0 blue:(float)0x99/255.0 alpha:1.00f];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void) setSelectedButton:(NSInteger)tagIndex
{
  NSLog(@"it is called");
  self.priority = [[NSNumber alloc] initWithInteger: tagIndex];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  iDCTaskDetailViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
  dvc.task = [self.tasks objectAtIndex:indexPath.row];
  [self.navigationController pushViewController:dvc animated:YES];
}

@end
