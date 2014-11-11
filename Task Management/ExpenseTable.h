//
//  ExpenseTable.h
//  Task Management
//
//  Created by  on 11/10/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ExpenseTable : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSManagedObject *expenses;

@end
