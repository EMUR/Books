//
//  SignupViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "SignupViewController.h"




@interface SignUpViewController ()

@end

@implementation SignUpViewController

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
    [_usernameField setDelegate:self];
    [_passwordField setDelegate:self];
    [_emailField setDelegate:self];
    [_mobileField setDelegate:self];
    
    // Do any additional setup after loading the view.
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Basic sign up



- (IBAction)signupBtn:(id)sender {
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email    = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *mobile = [self.mobileField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if ([username length] == 0 || [password length] == 0 || [email length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter ALL the information! Mobile is optional." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        PFUser *newUser = [PFUser user];
        
        newUser.username = username;
        newUser.email = email;
        newUser[@"mobile"] = mobile;
        newUser.password = password;
        
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else{
                [self dismissViewControllerAnimated:YES completion:nil];

                //[self.tabBarController setSelectedIndex:1];
            }
        }];
        
        
    }
}

- (IBAction)cancelBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_mobileField resignFirstResponder];
    [_emailField resignFirstResponder];

    return YES;
}




@end
