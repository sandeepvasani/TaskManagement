//
//  TMExpenseDetail.m
//  Task Management
//
//  Created by  on 11/10/14.
//  Copyright (c) 2014 CSCI 5737.01. All rights reserved.
//

#import "TMExpenseDetail.h"



@implementation TMExpenseDetail
@synthesize imgView,managedObjectContext,fetchedResultsController,nameTextbox,amountTextField;

-(id)initWithExpenseDetail:(ExpenseTable *)loginItem andManagedContext:(NSManagedObjectContext *)context 
{
    self = [super init];
    if (self) {
        self.managedObjectContext = context;
        self.expenseItem= loginItem;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  // self.imgView.image= [self loadImage];
    isFullScreen = false;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];
    tap.delegate = self;
    [imgView addGestureRecognizer:tap];
    [imgView setUserInteractionEnabled:YES];
    if( [[[self fetchedResultsController] fetchedObjects] count]>0)
    {
       
        Expenses *exp = [[[self fetchedResultsController] fetchedObjects] firstObject];
        if(exp.img!=NULL)
            [self.imgView setImage:[UIImage imageWithData:[exp valueForKey:@"img"]]];
        
        nameTextbox.text=exp.name;
        amountTextField.text=[NSString stringWithFormat:@"%@",exp.amount];
        
    }
    
    
    nameTextbox.delegate = self;
    
    UIDatePicker * datePicker = [[UIDatePicker alloc]init];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
     [datePicker setDate:[NSDate date]];
     self.nameTextbox.inputView = datePicker;
    
    self.nameTextbox.text = [self formatDate:datePicker.date];
[datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view from its nib.
}
-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.nameTextbox.inputView;
   
    self.nameTextbox.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
- (void)resetFetchedResultsController
{
    fetchedResultsController = nil;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"expensetable=%@",self.expenseItem];
    [fetchRequest setPredicate:predicate];
    
    // fetchRequest = self.todoItem.todolink;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[sortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"expenses"];
    
    NSError *error = nil;
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    BOOL shouldReceiveTouch = YES;
    NSLog(@"fasdfasd");
    if (gestureRecognizer == tap) {
        shouldReceiveTouch = (touch.view == imgView);
    }
    return shouldReceiveTouch;
}
- (void)showImagePicker:(UIImagePickerControllerSourceType)source{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = source;
    
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
}

-(void)imgToFullScreen{
    
    if (!isFullScreen) {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            //save previous frame
            prevFrame = imgView.frame;
            [imgView setFrame:[[UIScreen mainScreen] bounds]];
        }completion:^(BOOL finished){
            isFullScreen = true;
        }];
       
        return;
    } else {
        [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
            [imgView setFrame:prevFrame];
        }completion:^(BOOL finished){
            isFullScreen = false;
        }];
        return;
    }
}

- (IBAction)takePhoto:(id)sender {
//    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//	picker.delegate = self;
//
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo",
                                  @"Choose from existing", nil];
    [actionSheet showInView:self.view];
    
    
	[nameTextbox resignFirstResponder];
    [amountTextField resignFirstResponder];
//		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	
//		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	
	//[self presentViewController:picker animated:YES completion:nil];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    int i = buttonIndex;
    
    switch(i) {
            
        case 0:
        {
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
            }
            else
            {
                UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"Camera Not Available" message:@"Camera Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
              
                [altnot show];
                [altnot release];
                
            }
            
            //Code for camera
            
        }
            break;
        case 1:
        {
            [self showImagePicker:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }
            
        default:
            // Do Nothing.........
            break;
            
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.imgView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
  
    
}


- (IBAction)saveBtn:(id)sender {
    if(self.nameTextbox.text==NULL|| self.amountTextField.text==NULL )
        return;
    
    
    if( [[[self fetchedResultsController] fetchedObjects] count]>0)
    {
        
        Expenses *exp = [[[self fetchedResultsController] fetchedObjects] firstObject];
        [exp setName:self.nameTextbox.text];
        [exp setAmount:[ NSNumber numberWithFloat:[self.amountTextField.text floatValue ]]];
        //[expobj]
        if(self.imgView.image!=NULL)
            [exp setValue:UIImagePNGRepresentation(self.imgView.image) forKey:@"img"];
        exp.expensetable=self.expenseItem;
        self.expenseItem=exp.expensetable;
        NSError *error;
        if(![self.managedObjectContext save:&error])
        {
            // Handle the error.
            NSLog(@"errorrooro");
        }
        else
        {
            // Successfully added the record.
        }
        
    }
    
    
    else{
    
    Expenses  *expObj = (Expenses *)[NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [expObj setName:self.nameTextbox.text];
    [expObj setAmount:[ NSNumber numberWithFloat:[self.amountTextField.text floatValue ]]];
    //[expobj]
    if(self.imgView.image!=NULL)
   [expObj setValue:UIImagePNGRepresentation(self.imgView.image) forKey:@"img"];
   expObj.expensetable=self.expenseItem;
    self.expenseItem=expObj.expensetable;
    NSError *error;
    if(![self.managedObjectContext save:&error])
    {
        // Handle the error.
        NSLog(@"errorrooro");
    }
    else
    {
        // Successfully added the record.
    }
    [nameTextbox resignFirstResponder];
    [amountTextField resignFirstResponder];
    
    }
    
    
    UIAlertView *altnot=[[UIAlertView alloc]initWithTitle:@"SAVED" message:@"SAVED" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [altnot show];
    [altnot release];
   
}


- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex {
  
        
          [[self navigationController] popViewControllerAnimated:YES];
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
    if(theTextField==nameTextbox)
    {
        [nameTextbox resignFirstResponder];
    }
    if(theTextField==amountTextField)
    {
        [amountTextField resignFirstResponder];
    }
    return YES;
    
}

- (void)dealloc {
    [imgView release];
    [nameTextbox release];
    [amountTextField release];
    [super dealloc];
}


//- (void)saveImage: (UIImage*)image
//{
//    NSLog(@"saveimage called");
//    
//    if (image != nil)
//    {
//        NSLog(@"Image not null");
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                             NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                          @"test.png" ];
//        NSData* data = UIImagePNGRepresentation(image);
//        [data writeToFile:path atomically:YES];
//        imgView.image = nil;
//       self.imgView.image= [self loadImage];
//    }
//}
//
//- (UIImage*)loadImage
//{
//    NSError *error;
//    
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                      @"test.png" ];
//    UIImage* image = [UIImage imageWithContentsOfFile:path];
//    
//    // Write out the contents of home directory to console
//    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
//    
//    return image;
//}
@end
