//
//  Login.m
//  Task Management
//
//  Created by  on 11/2/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "Login.h"
#import "Password.h"


@implementation Login

@dynamic creationDate;
@dynamic name;
@dynamic usernames;



- (void)awakeFromInsert

{
    
    [super awakeFromInsert];
    
    [self setValue:[NSDate date] forKey:@"creationDate"];
}
@end
