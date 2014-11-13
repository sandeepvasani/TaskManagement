//
//  TMPassManagerTC.h
//  Task Management
//
//  Created by  on 11/2/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
#import "Password.h"

@interface TMPassManagerTC : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@end
