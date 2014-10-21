//
//  TMToDoTableViewController.h
//  Task Management
//
//  Created by  on 10/16/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMToDoTableViewController : UITableViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain) NSMutableArray *toDoItem;
- (IBAction)insertNewObject:(id)sender;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@end
