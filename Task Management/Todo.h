//
//  Todo.h
//  Task Management
//
//  Created by  on 10/29/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TodoItem;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * name;
//@property (nonatomic, retain) NSNumber * todoitemIndex;
@property (nonatomic, retain) TodoItem *todoitemlink;
- (void)toggleCompletion;
@end
