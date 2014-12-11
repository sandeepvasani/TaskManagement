//
//  TMAddtodo.m
//  Task Management
//
//  Created by  on 11/26/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMAddtodo.h"
#import "TodoItem.h"
#import "TMAppDelegate.h"


@implementation TMAddtodo
@synthesize addTitleTextBox,timeTextbox,swt,datePicker,managedObjectContext;
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
    
    TMAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    [self.timeTextbox setHidden:TRUE];
    
    self.timeTextbox.delegate = self;
    
    datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDate:[NSDate date]];
    self.timeTextbox.inputView = datePicker;
    
    self.timeTextbox.text = [self formatDate:datePicker.date];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.timeTextbox.inputView;
    
    self.timeTextbox.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"ccc, MM/dd/yy, hh:mm a"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}


- (void)clickedCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clickedDoneButton
{
    
    if(self.addTitleTextBox.text.length == 0)
    {
        UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Add title" message:@"Title cannot be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         [altnot setTag:11];
        [altnot show];
        [altnot release];
        [timeTextbox resignFirstResponder];
        return;
    }
    else
    {
        
        TodoItem *todoitemObj = (TodoItem *)[NSEntityDescription insertNewObjectForEntityForName:@"TodoItem" inManagedObjectContext:managedObjectContext];
        [todoitemObj setName:self.addTitleTextBox.text];
        
       
        if(swt.on==TRUE){
            [self scheduleNotificationForDate: datePicker.date];
            [todoitemObj setDueDate:datePicker.date];
        }
        
        NSError *error;if(![managedObjectContext save:&error])
        {
            // Handle the error.
        }
        else
        {
            // Successfully added the record.
        }
        
        UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"SAVED" message:@"SAVED" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [altnot setTag:12];
        [altnot show];
        [altnot release];
    }
    
    [timeTextbox resignFirstResponder];
    [addTitleTextBox resignFirstResponder];
    
    
    
}


- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if([alert tag] == 12)
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)scheduleNotificationForDate:(NSDate *)date
{
    // Here we cancel all previously scheduled notifications
   // [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = date;
    NSLog(@"Notification will be shown on: %@",localNotification.fireDate);
    
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = self.addTitleTextBox.text;
    localNotification.alertAction = NSLocalizedString(@"View details", nil);
    
    /* Here we set notification sound and badge on the app's icon "-1"
     means that number indicator on the badge will be decreased by one
     - so there will be no badge on the icon */
    
    localNotification.userInfo = [NSDictionary
					  dictionaryWithObjects:[NSArray arrayWithObjects:self.addTitleTextBox.text,nil]
                      forKeys:[NSArray arrayWithObjects: @"title",nil]];
   
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber = -1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [addTitleTextBox release];
    [timeTextbox release];
    [swt release];
    [super dealloc];
}
- (IBAction)toggleBtn:(id)sender {
    swt = (UISwitch *)sender;
    
    if(swt.on)
    {
       [self.timeTextbox setHidden:FALSE];
        [addTitleTextBox resignFirstResponder];
    }
    else{
        [self.timeTextbox setHidden:TRUE];
        [timeTextbox resignFirstResponder];
         [addTitleTextBox resignFirstResponder];
    }
}
@end
