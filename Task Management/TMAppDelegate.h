//
//  TMAppDelegate.h
//  Task Management
//
//  Created by  on 10/1/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMUITabBarController.h"
#import "TMToDoTableViewController.h"
#import "TMPassManagerTC.h"
#import "TMExpenseTable.h"
@interface TMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) TMUITabBarController * menuTC;
@property (nonatomic,retain) TMToDoTableViewController * todoVC;
@property (nonatomic,retain) TMPassManagerTC *passTVC;
@property (nonatomic,retain) TMExpenseTable *expTVC;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
