//
//  TMPassManagerTC.m
//  Task Management
//
//  Created by  on 11/2/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMPassManagerTC.h"
#import "TMAppDelegate.h"
#import "SavePasswordViewController.h"
#import "EnterMasterPassword.h"


@implementation TMPassManagerTC
@synthesize managedObjectContext,fetchedResultsController;
- (void)viewDidLoad
{
    [super viewDidLoad];
    EnterMasterPassword *myView = [[EnterMasterPassword alloc] initWithNibName:@"EnterMasterPassword" bundle:nil];
    myView .view.alpha = 1.f;
     myView.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
   // [myView.view setFrame:[[UIScreen mainScreen] bounds]];
    myView.view.opaque=YES;
    [self.navigationController.view addSubview:myView.view];
   // [self.view addSubview:myView.view];
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // [self presentViewController:myView animated:YES completion:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(insertNewObject:)];
    
    TMAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.toDoItem = [[NSMutableArray alloc] init];
        //self.title=@"ToDo";
        self.title=@"Logins";
        self.tabBarItem.title=@"Password";
        self.tabBarItem.image=[UIImage imageNamed:@"wallet.png"];
        
    }
    return self;
}


- (IBAction)insertNewObject: (id)sender {
    UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"New Login"
                                                   message:@"Title for new login"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
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
    Login *loginObj = (Login *)[NSEntityDescription insertNewObjectForEntityForName:@"Login" inManagedObjectContext:managedObjectContext];
    [loginObj setName:name];
    
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Login" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"MasterLogin"];
    
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
   return [[[self fetchedResultsController] fetchedObjects] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    
    Login *loginItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.textLabel.text = loginItem.name;
    //cell.textLabel.text = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
       
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
        
      
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error;
        if (![context save:&error])
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Login" message:@"Sorry the Item Cannot be deleted" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Login *loginItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    // Navigation logic may go here, for example:
    // Create the next view controller.
    SavePasswordViewController *detailViewController = [[SavePasswordViewController alloc] initWithSavePassword:loginItem andManagedContext:self.managedObjectContext andTableIndexPath:indexPath];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
