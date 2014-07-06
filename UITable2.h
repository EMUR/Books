//
//  UITable.h
//  book
//
//  Created by E on 6/7/14.
//  Copyright (c) 2014 E. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface UITable2 : PFQueryTableViewController

@property (nonatomic,weak)  NSString *condtion;
@property (strong,nonatomic) NSString *categoryName;



@end
