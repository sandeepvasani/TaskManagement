//
//  TMToDoListTableViewController.h
//  Task Management
//
//  Created by  on 10/22/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMToDoListTableViewController : UITableViewController <UITableViewDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@property (retain) NSString* toDoItemTitle;
@property (assign) NSInteger toDoItemIndex;
@end
