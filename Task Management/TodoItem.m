//
//  TodoItem.m
//  Task Management
//
//  Created by  on 10/20/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TodoItem.h"


@implementation TodoItem

@dynamic name;
@dynamic creationDate;



//- (void)willSave
//{
//    if (self.creationDate == nil) {
//        self.creationDate = [[NSDate alloc] init];
//    }
//}


- (void)awakeFromInsert
{
    [super awakeFromInsert];
    //[self setPrimitiveValue:@NO forKey:@"completed"];
    [self setValue:[NSDate date] forKey:@"creationDate"];
}

@end