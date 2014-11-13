//
//  EnterMasterPassword.m
//  project_MAD_Password
//
//  Created by Nishikant Raje on 11/10/14.
//  Copyright (c) 2014 UHCL. All rights reserved.
//

#import "EnterMasterPassword.h"
#import "TMAppDelegate.h"



@implementation EnterMasterPassword
@synthesize masterPasswordTextField,masterUsernameTextField;

-(void)dealloc
{
       
    [masterUsernameTextField release];
    [masterPasswordTextField release];
    [super dealloc];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        [self.window makeKeyAndVisible];
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

- (IBAction)Login:(id)sender {
    if(masterPasswordTextField.text==nil || masterUsernameTextField.text==nil)
        return;
    
    if([masterUsernameTextField.text isEqualToString:@"neha"] && [masterPasswordTextField.text isEqualToString:@"12345"])
   [self.view removeFromSuperview];
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error"
                                                        message:@"Invalid Username or Password."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if(theTextField==masterUsernameTextField)
    {
        [masterUsernameTextField resignFirstResponder];
    }
    if(theTextField==masterPasswordTextField)
    {
        [masterPasswordTextField resignFirstResponder];
    }
    
    return YES;
}

@end
