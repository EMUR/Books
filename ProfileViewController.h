//
//  AboutMeViewController.h
//  usedBookMarket
//
//  Created by Tony's Mac on 6/2/14.
//  Copyright (c) 2014 TonyCP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"



@interface ProfileViewController : UIViewController
{
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;

    UIScrollView *photoScrollView;
    NSMutableArray *allImages;

}

@property (nonatomic,weak) IBOutlet UIImageView *image;
@property(nonatomic,weak) IBOutlet  UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *totalPost;
@property (strong, nonatomic) IBOutlet PFImageView *profilePic;
@property(nonatomic) int postCount;
@property(strong, nonatomic) NSString *imageId;

- (IBAction)logOutBtn:(id)sender;

@end
