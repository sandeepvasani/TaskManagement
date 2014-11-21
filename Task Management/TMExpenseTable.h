//
//  TMExpenseTable.h
//  Task Management
//
//  Created by  on 11/10/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMExpenseDetail.h"
#import "ExpenseTable.h"

@interface TMExpenseTable : UITableViewController
{
    float sum;

}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
@end
