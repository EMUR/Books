//
//  SignupViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
//#import <FacebookSDK/FacebookSDK.h>


@interface SignUpViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *mobileField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)signupBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;



@end
