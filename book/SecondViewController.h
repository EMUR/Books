//
//  SecondViewController.h
//  book
//
//  Created by E on 6/3/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class UITable2;

@interface SecondViewController : UIViewController

@property (strong, nonatomic) UITable2* UITable2;

+(NSArray*)allCategories;

@end
