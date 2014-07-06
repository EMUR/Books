//
//  AboutMeViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 6/2/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "ProfileViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"





@interface ProfileViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, MBProgressHUDDelegate>



@end

@implementation ProfileViewController
{
    
}

@synthesize profilePic;
-(void)viewDidLoad
{

    [super viewDidLoad];
    
    // allImages = [[NSMutableArray alloc] init];
    
    CALayer * l = [profilePic layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:70.0];
    
    // You can even add a border
    [l setBorderWidth:4.0];
    [l setBorderColor:[[UIColor colorWithRed:(179.0/255.0) green:(179.0/255.0) blue:(179.0/255.0) alpha:(0.3)] CGColor]];
    [l setShadowColor:(__bridge CGColorRef)([UIColor blueColor])];
    [l setShadowOffset:CGSizeMake(10.0f, 10.0f)];
    
    [self getdata];
    
    

    
    

}


-(void)getdata
{

    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:[[PFUser currentUser] objectId]];
    _email.text = [[PFUser currentUser] email];
    
    NSString *totalPostString = [@"Total Post: " stringByAppendingFormat:@"%d", [self countTotalPost]];
    _totalPost.text = totalPostString;

    
    
    PFUser *user = [PFUser currentUser];
   _name.text = user.username;
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"UserPhoto"];
    [query2 whereKey:@"user" equalTo:user];
    [query2 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        }
        else
        {
            NSLog(@"Successfully retrieved the object.");
            
            PFFile *file = [object objectForKey:@"imageFile"];
            self.profilePic.file = file;
            [self.profilePic loadInBackground];
            [self.profilePic reloadInputViews];
        }
    }];
    
    
    
}

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
    
    profilePic.image = smallImage;
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    [self uploadImage:imageData];
}


- (void)uploadImage:(NSData *)imageData
{
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeDeterminate;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    
# pragma mark  - delete old profile pic
    //check current user has any existing photo, delete old profile pic,
    //To ensure each user only has one profile pic in the database.

    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The imageId request failed.");
        }
        else
        {
            NSLog(@"Successfully retrieved the imageId.");
            
            self.imageId = [object objectId];
            
            NSLog(@"%@", self.imageId);
            
            PFObject *object2 = [PFObject objectWithoutDataWithClassName:@"UserPhoto" objectId:self.imageId];
            //[object2 deleteInBackground];
            [object2 deleteEventually];
            
            //            //This callback method provides feedback to the user
            //            [object2 deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            //
            //                if (!succeeded) {
            //                    NSLog(@" UNSucceeded to delete");
            //                    return ;
            //                }
            //                NSLog(@" Succeeded to delete");
            //                return ;
            //                
            //            }];

        }
    }];
    
    
    // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //Hide determinate HUD
            [HUD hide:YES];
            
            // Show checkmark
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            // Set custom view mode
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            
            // Create a PFObject around a PFFile and associate it with the current user
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            // Set the access control list to current user for security purposes
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    [self refresh:nil];
                }
                else{
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        HUD.progress = (float)percentDone/100;
    }];
    
}

    
    
//[gameScore removeObjectForKey:@"playerName"];
//
//// Saves the field deletion to the Parse Cloud
//[gameScore saveInBackground];


- (void)refresh:(id)sender
{
    refreshHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:refreshHUD];
	
    refreshHUD.delegate = self;
	
    [refreshHUD show:YES];
    
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query orderByAscending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            if (refreshHUD) {
                [refreshHUD hide:YES];
                
                refreshHUD = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:refreshHUD];
                
                refreshHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                
                // Set custom view mode
                refreshHUD.mode = MBProgressHUDModeCustomView;
                
                refreshHUD.delegate = self;
            }
            NSLog(@"Successfully retrieved %lu photos.", (unsigned long)objects.count);
        }
    }];
}


-(int) countTotalPost
{
    PFQuery *query = [PFQuery queryWithClassName:@"Books_DataBase"];
    [query whereKey:@"sellerId" equalTo:[[PFUser currentUser]objectId]];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
          //  NSLog(@"You have %d post", count);
            
            self.postCount = count;
            
             NSLog(@"You have %d post", self.postCount);
            
        } else {
            // The request failed
        }
    }];
    return self.postCount;
}

- (IBAction)logOutBtn:(id)sender {
    [PFUser logOut];
    [self.tabBarController setSelectedIndex:0];
}
@end
