//
//  TodoItem.h
//  Task Management
//
//  Created by  on 11/28/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface TodoItem : NSManagedObject

@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *todolink;
@end

@interface TodoItem (CoreDataGeneratedAccessors)

- (void)addTodolinkObject:(Todo *)value;
- (void)removeTodolinkObject:(Todo *)value;
- (void)addTodolink:(NSSet *)values;
- (void)removeTodolink:(NSSet *)values;

@end
