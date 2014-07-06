//
//  addBook.h
//  BookExchangeV7
//
//  Created by David Phan on 6/2/14.
//  Copyright (c) 2014 David Phan. All rights reserved.
//


#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface PostBookViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
{
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
}



@end