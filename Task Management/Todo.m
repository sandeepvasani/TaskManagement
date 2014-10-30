//
//  Todo.m
//  Task Management
//
//  Created by  on 10/29/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "Todo.h"
#import "TodoItem.h"


@implementation Todo

@dynamic completed;
@dynamic creationDate;
@dynamic name;
//@dynamic todoitemIndex;
@dynamic todoitemlink;


- (void)toggleCompletion

{
    
    self.completed = [NSNumber numberWithBool:![self.completed boolValue]];
    
    
    
}


- (void)awakeFromInsert

{
    
    [super awakeFromInsert];
    
    //[self setPrimitiveValue:@NO forKey:@"completed"];
    
    [self setValue:[NSDate date] forKey:@"creationDate"];
    
    [self setPrimitiveValue:@NO forKey:@"completed"];
    
}


@end
