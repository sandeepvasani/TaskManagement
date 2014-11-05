//
//  SavePasswordViewController.m
//  table
//
//  Created by Nishikant Raje on 10/23/14.
//  Copyright (c) 2014 UHCL. All rights reserved.
//

#import "SavePasswordViewController.h"


@implementation SavePasswordViewController

@synthesize savePassword,saveUsername,label,managedObjectContext,fetchedResultsController;

-(id)initWithSavePassword:(Login *)loginItem andManagedContext:(NSManagedObjectContext *)context andTableIndexPath:(NSIndexPath*)indexPath
{
    self = [super init];
    if (self) {
        self.managedObjectContext = context;
        self.loginItem = loginItem;
        self.tableindexPath=indexPath;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   if( [[[self fetchedResultsController] fetchedObjects] count]>0)
    {
        Password *pass = [[[self fetchedResultsController] fetchedObjects] firstObject];
        saveUsername.text=pass.userName;
        savePassword.text=pass.password;
    
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [fetchedResultsController release];
    [saveUsername release];
    [savePassword release];
    [label release];
    [super dealloc];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"login=%@",self.loginItem];
    [fetchRequest setPredicate:predicate];
    
    // fetchRequest = self.todoItem.todolink;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userName" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Password"];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}

- (IBAction)saveBtn:(id)sender {
    if(self.saveUsername.text==NULL|| self.savePassword.text==NULL )
        return;
    Password  *passwordObj = (Password *)[NSEntityDescription insertNewObjectForEntityForName:@"Password" inManagedObjectContext:self.managedObjectContext];
    [passwordObj setUserName:self.saveUsername.text];
    [passwordObj setPassword:self.savePassword.text];
    //[todoObj t];
    //[todoObj setValue:[NSNumber numberWithInt:self.toDoItemIndex] forKey:@"todoitemIndex"];
    //[self.loginItem ];
    passwordObj.login=self.loginItem;
    NSError *error;if(![self.managedObjectContext save:&error])
    {
        // Handle the error.
        NSLog(@"errorrooro");
    }
    else
    {
        // Successfully added the record.
    }
     [savePassword resignFirstResponder];
    [saveUsername resignFirstResponder];
}




- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if(theTextField==savePassword)
    {
        [savePassword resignFirstResponder];
    }
    if(theTextField==saveUsername)
    {
        [saveUsername resignFirstResponder];
    }
    return YES;

}
@end
