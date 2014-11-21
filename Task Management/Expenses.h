//
//  Expenses.h
//  Task Management
//
//  Created by  on 11/21/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExpenseTable;

@interface Expenses : NSManagedObject

@property (nonatomic, retain) NSNumber * amount;
@property (nonatomic, retain) NSData * img;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ExpenseTable *expensetable;

@end
