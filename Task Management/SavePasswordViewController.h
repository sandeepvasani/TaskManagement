//
//  SavePasswordViewController.h
//  table
//
//  Created by Nishikant Raje on 10/23/14.
//  Copyright (c) 2014 UHCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMPassManagerTC.h"
#import "Password.h"

@interface SavePasswordViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *saveUsername;
@property (retain, nonatomic) IBOutlet UITextField *savePassword;
@property (retain, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
- (IBAction)saveBtn:(id)sender;

//@property (assign) NSInteger toDoItemIndex;
@property (strong, nonatomic) Login *loginItem;
@property (strong,nonatomic) NSIndexPath * tableindexPath;
-(id)initWithSavePassword:(Login *)loginItem andManagedContext:(NSManagedObjectContext *)context andTableIndexPath:(NSIndexPath*)indexPath;
@end
