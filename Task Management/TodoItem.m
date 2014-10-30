//
//  TodoItem.m
//  Task Management
//
//  Created by  on 10/29/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TodoItem.h"
#import "Todo.h"


@implementation TodoItem

@dynamic creationDate;
@dynamic name;
@dynamic todolink;


- (void)awakeFromInsert

{
    
    [super awakeFromInsert];
    
    //[self setPrimitiveValue:@NO forKey:@"completed"];
    
    [self setValue:[NSDate date] forKey:@"creationDate"];
    
}


@end
