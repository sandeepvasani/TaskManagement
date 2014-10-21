//
//  TodoItem.h
//  Task Management
//
//  Created by  on 10/20/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TodoItem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * creationDate;

@end
