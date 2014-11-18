//
//  TMExpenseDetail.h
//  Task Management
//
//  Created by  on 11/10/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseTable.h"
#import "Expenses.h"

@interface TMExpenseDetail : UIViewController<UIImagePickerControllerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
}
- (IBAction)takePhoto:(id)sender;
- (IBAction)saveBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *imgView;
@property (retain, nonatomic) IBOutlet UITextField *nameTextbox;
@property (strong, nonatomic) ExpenseTable *expenseItem;
@property (retain, nonatomic) IBOutlet UITextField *amountTextField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

-(id)initWithExpenseDetail:(ExpenseTable *)loginItem andManagedContext:(NSManagedObjectContext *)context ;
-(NSFetchedResultsController *)fetchedResultsController;
@end
