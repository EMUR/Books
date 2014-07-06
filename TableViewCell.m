//
//  TableViewCell.m
//  book
//
//  Created by E on 6/3/14.
//  Copyright (c) 2014 E. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize name,sub,price,con;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        // Initialization code

            
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
