//
//  LoginViewController.m
//  usedBookMarket
//
//  Created by Tony's Mac on 5/31/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewDidLoad
{
    [_usernameField setDelegate:self];
    [_passwordField setDelegate:self];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)usernameField{
    
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];

    return YES;
}

- (IBAction)loginBtn:(id)sender {
    
    refreshHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:refreshHUD];
	
    refreshHUD.delegate = self;
	
    [refreshHUD show:YES];
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [password length] == 0) {
        [refreshHUD hide:YES];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure you enter the Username and Password!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    
    else{
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                if (refreshHUD)
                    [refreshHUD hide:YES];

                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            else{
                if (refreshHUD)
                    [refreshHUD hide:YES];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }];
        
        
    }
}



@end





