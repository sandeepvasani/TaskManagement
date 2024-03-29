//
//  TMExpenseTable.m
//  Task Management
//
//  Created by  on 11/10/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMExpenseTable.h"
#import "TMAppDelegate.h"
#import "Expenses.h"


@implementation TMExpenseTable
@synthesize managedObjectContext,fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.toDoItem = [[NSMutableArray alloc] init];
        //self.title=@"ToDo";
        self.title=@"Expenses";
        self.tabBarItem.title=@"Expense Tracker";
        self.tabBarItem.image=[UIImage imageNamed:@"dollar.png"];
        
    }
    return self;
}

-(void) viewWillAppear: (BOOL) animated {
    [self resetFetchedResultsController];
    [self.tableView reloadData];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sum=0;
    //self.bottomFloatingView.layer.zPosition=100;
    
   // [self.tableView addSubview:self.bottomFloatingView];
   // self.tableView.tableFooterView=self.bottomFloatingView;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(insertNewObject:)];
    
    TMAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (IBAction)insertNewObject: (id)sender {
    UIAlertView* alert= [[UIAlertView alloc] initWithTitle:@"New Expense"
                                                   message:@"Title for new expense:"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"Create", nil];
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
    ExpenseTable *expitemObj = (ExpenseTable *)[NSEntityDescription insertNewObjectForEntityForName:@"ExpenseTable" inManagedObjectContext:managedObjectContext];
    [expitemObj setName:name];
    
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ExpenseTable" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Masterexpense"];
    
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
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    
    ExpenseTable *expItem = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     cell.textLabel.text = expItem.name;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"expensetable=%@",expItem];
    [fetchRequest setPredicate:predicate];
    
    // fetchRequest = self.todoItem.todolink;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
   NSFetchedResultsController* fetchedResultsController2 = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"expenses"];
    
    
    NSError *error = nil;
    if (![fetchedResultsController2 performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
     Expenses *exp = [[fetchedResultsController2 fetchedObjects] firstObject];
      cell.detailTextLabel.text =[NSString stringWithFormat:@"%@%.2f", @"$ ", [exp.amount floatValue]];
        // [[objects objectAtIndex:0] valueForKey:@"amount"]
        //  int a=[[objects objectAtIndex:0] valueForKey:@"amount"];
    
        
   
   // [objects release];
    
    //cell.textLabel.text = [[self fetchedResultsController] objectAtIndexPath:indexPath];
   // [self.managedObjectContext save:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    NSLog(@"called");
    
   // CGRect loadingViewRect = CGRectMake(0, 0, self.tableView.frame.size.width, self.view.frame.size.height*0.5);
    UIView* bottomFloatingView = [[[UIView alloc] init] autorelease];
    [bottomFloatingView setBackgroundColor:[UIColor redColor]];
   
    UILabel * lbl=[[UILabel alloc] initWithFrame:CGRectMake(0,0,self.tableView.frame.size.width*0.5,20)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = @" Total";
    lbl.textAlignment = NSTextAlignmentLeft;
    //[lbl setNumberOfLines:10];//set line if you need
    [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];//font size and style
    [lbl setTextColor:[UIColor blackColor]];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    NSError *error;
    NSArray *objects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
      sum=[[objects valueForKeyPath:@"@sum.amount"]floatValue];
  
    //[objects release];
    UILabel * lbl2=[[UILabel alloc] initWithFrame:CGRectMake(0,0,self.tableView.frame.size.width-20,20)];
    lbl2.backgroundColor = [UIColor clearColor];
    lbl2.text = [NSString stringWithFormat:@"%s %.2f","$",sum];
    lbl2.textAlignment = NSTextAlignmentRight;
    //[lbl setNumberOfLines:10];//set line if you need
    [lbl2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];//font size and style
    [lbl2 setTextColor:[UIColor blackColor]];
    
    [bottomFloatingView addSubview:lbl2];

    [bottomFloatingView addSubview:lbl];
    [lbl release];
    [lbl2 release];
    return bottomFloatingView;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.view.frame.size.height*0.05;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
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
     ExpenseTable *expItem = (ExpenseTable *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    TMExpenseDetail *detailViewController = [[TMExpenseDetail alloc] initWithExpenseDetail:expItem andManagedContext:self.managedObjectContext];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//- (void)removeImage:(NSString *)fileName
//{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:fileName];
//    NSError *error;
//    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
//    if (success) {
//        UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Congratulation:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
//        [removeSuccessFulAlert show];
//    }
//    else
//    {
//        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
//    }
//}

- (void)dealloc
{
    [managedObjectContext release];
    [fetchedResultsController release];
   // [self.tableView removeObserver:self forKeyPath:@"frame"];
    [super dealloc];
}

@end
