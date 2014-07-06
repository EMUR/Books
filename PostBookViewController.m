//
//  addBook.m
//  BookExchangeV7
//
//  Created by David Phan on 6/2/14.
//  Copyright (c) 2014 David Phan. All rights reserved.
//
#import "PostBookViewController.h"
#import "SecondViewController.h"
#import "HoldBooks.h"

@interface PostBookViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameInput;

@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *author;

@property (weak, nonatomic) IBOutlet UITextField *subjectInput;

@property (weak, nonatomic) IBOutlet UITextField *conditionInput;

@property (strong, nonatomic) IBOutlet UIPickerView *subject;
@property (strong, nonatomic) IBOutlet UIPickerView *conditionPicker;

@property (strong, nonatomic) IBOutlet PFImageView *bookcover;

@property (strong, nonatomic) HoldBooks *addBook;
@property NSArray *categories;
@property NSArray *conditions;

@end



@implementation PostBookViewController


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if(pickerView.tag == 1){
        return [self.categories count];
    }else{return [self.conditions count];}
}




-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
   // label.backgroundColor = [UIColor whiteColor];
    //label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:19];
    label.textAlignment = NSTextAlignmentCenter;
    if(pickerView.tag == 1){
        label.text = [self.categories objectAtIndex:row];
    }else{
        label.text = [self.conditions objectAtIndex:row];
        
    }
    
    return label;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)createPickerView{
    // Do any additional setup after loading the view.
    self.categories = [SecondViewController allCategories];
    self.conditions = [NSArray arrayWithObjects:@"Like-New",@"Heavily-Used",nil];
    
    self.subject = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 270)];
    self.subject.delegate = self;
    self.subject.dataSource = self;
    self.subject.tag = 1;
    [self.view addSubview:self.subject];
    
    self.conditionPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 270)];
    self.conditionPicker.delegate = self;
    self.conditionPicker.dataSource = self;
    self.conditionPicker.tag = 2;
    [self.view addSubview:self.conditionPicker];
    
    
    
    
    //-----------Done Button for Subject Picker---------------
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleDefault;
    [mypickerToolbar sizeToFit];
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    [mypickerToolbar setItems:barItems animated:YES];
    
    self.subjectInput.inputAccessoryView = mypickerToolbar;
    
    
    UIToolbar*  mypickerToolbar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar2.barStyle = UIBarStyleDefault;
    [mypickerToolbar2 sizeToFit];
    NSMutableArray *barItems2 = [[NSMutableArray alloc] init];
    UIBarButtonItem *flexSpace2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems2 addObject:flexSpace2];
    UIBarButtonItem *doneBtn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked2)];
    [barItems2 addObject:doneBtn2];
    [mypickerToolbar2 setItems:barItems2 animated:YES];
    
    
    
    self.conditionInput.inputAccessoryView = mypickerToolbar2;
    
    
    //---------------------------------------
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_nameInput setDelegate:self];
    [_author setDelegate:self];
    [_price setDelegate:self];

    
    [self createPickerView];
    self.subjectInput.inputView = self.subject;
    self.conditionInput.inputView = self.conditionPicker;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
  //  [_passwordField resignFirstResponder];
    
    return YES;
}



-(void)pickerDoneClicked
{
    NSLog(@"Done Clicked");
    NSInteger row = [self.subject selectedRowInComponent:0];
    self.subjectInput.text = [self.categories objectAtIndex:row];
    [self.subjectInput resignFirstResponder];
}


-(void)pickerDoneClicked2
{
    NSLog(@"Done Clicked");
    NSInteger row = [self.conditionPicker selectedRowInComponent:0];
    self.conditionInput.text = [self.conditions objectAtIndex:row];
    if ([_conditionInput.text isEqualToString:@"Like-New"])
    {
        [self.conditionInput setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"green.png"]]];
  
    }
    else if ([_conditionInput.text isEqualToString:@"Heavily-Used"])
    {
        [self.conditionInput setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"red.png"]]];

    }
    [self.conditionInput resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelButton:(id)sender {
    [self.subjectInput resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postBook:(id)sender {
    
    if (_nameInput.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Make sure you entered all the book's information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else
    {
    if(!self.addBook){
        self.addBook = [[HoldBooks alloc] init];
    }
    
    NSLog(@"Post Button works");
    
    self.addBook.bookName = self.nameInput.text;
    self.addBook.price = self.price.text;
    self.addBook.author = self.author.text;
    self.addBook.picture = self.bookcover;
        

    
    NSInteger row = [self.subject selectedRowInComponent:0];
    self.addBook.subject = [self.categories objectAtIndex:row];
    NSInteger row2 = [self.conditionPicker selectedRowInComponent:0];
    self.addBook.condition = [self.conditions objectAtIndex:row2];

    [PostBookViewController pushBook:self.addBook];
    }
    
    
}

+(void)pushBook:(HoldBooks*)thisBook{
    PFObject *bookToPush = [PFObject objectWithClassName:@"Books_DataBase"];
    bookToPush[@"Subject"] = thisBook.subject;
    bookToPush[@"BookName"] = thisBook.bookName;
    bookToPush[@"AuthorName"] = thisBook.author;
    bookToPush[@"Price"] = thisBook.price;
    bookToPush[@"Condition"] = thisBook.condition;
    bookToPush[@"Condition"] = thisBook.condition;
    [bookToPush setObject:[[PFUser currentUser] objectId] forKey:@"sellerId"];
    [bookToPush setObject:[[PFUser currentUser] username] forKey:@"sellerName"];

    NSData *imageData = UIImageJPEGRepresentation(thisBook.picture.image, 0.05f);
        
    [self uploadImage:imageData:bookToPush];

    
    
    [bookToPush saveInBackground];
}

+ (void)uploadImage:(NSData *)imageData:(PFObject*)sub
{
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
           
            [sub setObject:imageFile forKey:@"image"];
            
            
            [sub saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            }];
        }
        else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
    }];
    
}


/*--------------------Use for Eddie old version DB--------------------
 
 
 +(void)pushBook:(BOOK*)thisBook{
 PFObject *bookToPush = [PFObject objectWithClassName:thisBook.category];
 bookToPush[@"Name"] = thisBook.bookName;
 bookToPush[@"Author"] = thisBook.author;
 bookToPush[@"Price"] = thisBook.price;
 [bookToPush saveInBackground];
 }
 
 --------------------------------------------------------*/

- (IBAction)showNormalActionSheet:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Where do you want to get the picture from?"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take a picture", @"Open Camera Roll", nil];
    [actionSheet showInView:self.view];
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
    }
    else if (buttonIndex == 1)
    {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }
    else
    {
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.bookcover.image = smallImage;
    //NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
}







@end
