//
//  TMUITabBarController.m
//  Task Management
//
//  Created by  on 10/1/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMUITabBarController.h"


@implementation TMUITabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [_tabController release];
    [super dealloc];
}
@end
