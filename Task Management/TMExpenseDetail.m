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
   
    
    if( [[[self fetchedResultsController] fetchedObjects] count]>0)
    {
       
        Expenses *exp = [[[self fetchedResultsController] fetchedObjects] firstObject];
        if(exp.img!=NULL)
            [self.imgView setImage:[UIImage imageWithData:[exp valueForKey:@"img"]]];
        
        nameTextbox.text=exp.name;
        amountTextField.text=[NSString stringWithFormat:@"%@",exp.amount];
        
    }

    // Do any additional setup after loading the view from its nib.
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


- (void)showImagePicker:(UIImagePickerControllerSourceType)source{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = source;
    
    imgPicker.delegate = self;
    [self presentViewController:imgPicker animated:YES completion:nil];
}
- (IBAction)takePhoto:(id)sender {
//    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
//	picker.delegate = self;
//	
//	
//		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	[self showImagePicker:UIImagePickerControllerSourceTypeCamera];
//		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	
	
	//[self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	self.imgView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    Expenses  *expObj = (Expenses *)[NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
//    [expObj setValue:UIImagePNGRepresentation(self.imgView.image) forKey:@"img"];
//    Expenses *exp = [[[self fetchedResultsController] fetchedObjects] firstObject];
//    if(exp.img!=NULL)
//        [self.imgView setImage:[UIImage imageWithData:[exp valueForKey:@"img"]]];
    
}


- (IBAction)saveBtn:(id)sender {
    if(self.nameTextbox.text==NULL|| self.amountTextField.text==NULL )
        return;
    Expenses  *expObj = (Expenses *)[NSEntityDescription insertNewObjectForEntityForName:@"Expenses" inManagedObjectContext:self.managedObjectContext];
    [expObj setName:self.nameTextbox.text];
    [expObj setAmount:[ NSNumber numberWithInteger:[self.amountTextField.text integerValue ]]];
    //[expobj]
    if(self.imgView.image!=NULL)
   [expObj setValue:UIImagePNGRepresentation(self.imgView.image) forKey:@"img"];
   expObj.expensetable=self.expenseItem;
    NSError *error;if(![self.managedObjectContext save:&error])
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
