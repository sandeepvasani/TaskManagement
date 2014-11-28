//
//  TMToDoTableViewController.m
//  Task Management
//
//  Created by  on 10/16/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMToDoTableViewController.h"
#import "TodoItem.h"
#import "TMAppDelegate.h"
#import "TMToDoListTableViewController.h"
#import "TMAddtodo.h"


@implementation TMToDoTableViewController
@synthesize managedObjectContext,fetchedResultsController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         //self.toDoItem = [[NSMutableArray alloc] init];
        //self.title=@"ToDo";
        self.title=@"Todo List";
        self.tabBarItem.title=@"Todo";
        self.tabBarItem.image=[UIImage imageNamed:@"todo.png"];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // self.toDoItems = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(insertNewObject:)];
    
    TMAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    
}
-(void) viewWillAppear: (BOOL) animated {
    [self resetFetchedResultsController];
    [self.tableView reloadData];
    
}
- (IBAction)insertNewObject: (id)sender {
//    UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"New To-Do List"
//                                                   message:@"Title for new list:"
//                                                  delegate:self
//                                         cancelButtonTitle:@"Cancel"
//                                         otherButtonTitles:@"Create", nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert show];
    
     TMAddtodo *addTitleVC = [[TMAddtodo alloc] initWithNibName:@"TMAddtodo" bundle:nil];
    
    UINavigationController *addTitleNC = [[UINavigationController alloc] initWithRootViewController:addTitleVC];
    [self presentViewController:addTitleNC animated:YES completion:nil];
}


- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0) {
        NSString* title = [alert textFieldAtIndex: 0].text;
        if (title.length > 0) {
           
              //[self.toDoItem addObject:title];
            [self addTodoItem:title];
            //self.toDoItem.completed = NO;
            [self resetFetchedResultsController];
            [self.tableView reloadData];
          
            
        }
    }
}

-(void)addTodoItem:(NSString *)name
{
    TodoItem *todoitemObj = (TodoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TodoItem" inManagedObjectContext:managedObjectContext];
    [todoitemObj setName:name];
    
    NSError *error;if(![managedObjectContext save:&error])
    {
        // Handle the error.
    }
    else
    {
        // Successfully added the record.
    }
}



- (void)resetFetchedResultsController
{
    fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TodoItem" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
   return [[[self fetchedResultsController] fetchedObjects] count];
}


-(void) dealloc
{
    //[toDoItem release];
    [managedObjectContext release];
    [fetchedResultsController release];
    [super dealloc];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    
   TodoItem *toDoItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.textLabel.text = toDoItem.name;
    if(!([[self formatDate:toDoItem.dueDate] isEqualToString:@"Sat, 12/12/99, 0:0 PM"]))
    cell.detailTextLabel.text=[self formatDate:toDoItem.dueDate];
    //cell.textLabel.text = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"ccc, MM/dd/yy, K:m a"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *eventArray = [app scheduledLocalNotifications];
        for (int i=0; i<[eventArray count]; i++)
        {
            UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
            NSDictionary *userInfoCurrent = oneEvent.userInfo;
            NSString *uid=[NSString stringWithFormat:@"%@",[userInfoCurrent valueForKey:@"title"]];
            if ([uid isEqualToString:cell.textLabel.text])
            {
                //Cancelling local notification
                [app cancelLocalNotification:oneEvent];
                NSLog(@"cancelling notification");
                break;
            }
        }

        
        
        // Delete the row from the data source
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error;
        if (![context save:&error])
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"ToDo" message:@"Sorry the Item Cannot be deleted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        [self resetFetchedResultsController];
        [self.tableView reloadData];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    TodoItem *todoItem = (TodoItem *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //TMToDoListTableViewController *detailViewController = [[TMToDoListTableViewController alloc] initWithNibName:@"TMToDoListTableViewController" bundle:nil];
 //  TodoItem *toDoItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    TMToDoListTableViewController *detailViewController = [[TMToDoListTableViewController alloc] initWithTodoItem:todoItem andManagedContext:self.managedObjectContext];
    
    //detailViewController.toDoItemTitle=toDoItem.name;
    //detailViewController.toDoItemIndex= indexPath.item;
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}


@end
