//
//  TableViewCell.h
//  book
//
//  Created by E on 6/3/14.
//  Copyright (c) 2014 E. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UILabel *name;
@property (weak,nonatomic) IBOutlet UILabel *sub;
@property (weak,nonatomic) IBOutlet UILabel *price;
@property (weak,nonatomic) IBOutlet UILabel *author;
@property (retain,nonatomic) IBOutlet UIImageView *con;

@property (retain,nonatomic) IBOutlet UIImageView *cover;


@end
