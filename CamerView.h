//
//  ProfileCameraViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/5/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


@interface CamerView : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@end
