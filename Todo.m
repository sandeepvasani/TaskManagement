//
//  Todo.m
//  Task Management
//
//  Created by  on 10/22/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "Todo.h"


@implementation Todo

@dynamic completed;
@dynamic name;
@dynamic todoitemIndex;
@dynamic creationDate;



- (void)awakeFromInsert
{
    [super awakeFromInsert];
    //[self setPrimitiveValue:@NO forKey:@"completed"];
    [self setValue:[NSDate date] forKey:@"creationDate"];
    [self setPrimitiveValue:@NO forKey:@"completed"];
}
@end
