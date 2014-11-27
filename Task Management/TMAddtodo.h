//
//  TMAddtodo.h
//  Task Management
//
//  Created by  on 11/26/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAddtodo : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *addTitleTextBox;
- (IBAction)toggleBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *timeTextbox;

@end
