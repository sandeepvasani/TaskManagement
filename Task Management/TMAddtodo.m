//
//  TMAddtodo.m
//  Task Management
//
//  Created by  on 11/26/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMAddtodo.h"


@implementation TMAddtodo
@synthesize addTitleTextBox,timeTextbox;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clickedCancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickedDoneButton)];
}

- (void)clickedCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clickedDoneButton
{
    
    if(self.addTitleTextBox.text && self.addTitleTextBox.text.length == 0)
    {
        UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Add title" message:@"Title cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [altnot show];
        [altnot release];
        return;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [addTitleTextBox release];
    [timeTextbox release];
    [super dealloc];
}
- (IBAction)toggleBtn:(id)sender {
}
@end
