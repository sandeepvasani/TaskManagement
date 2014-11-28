//
//  TMAddtodo.h
//  Task Management
//
//  Created by  on 11/26/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMAddtodo : UIViewController<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *addTitleTextBox;
@property (retain, nonatomic) UIDatePicker * datePicker;
- (IBAction)toggleBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *timeTextbox;
@property (nonatomic, retain) IBOutlet UISwitch *swt;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
