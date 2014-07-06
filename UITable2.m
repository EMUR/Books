//
//  UITable.m
//  book
//
//  Created by E on 6/7/14.
//  Copyright (c) 2014 E. All rights reserved.
//

#import "UITable2.h"
#import "BooksDetailsViewController.h"
#include "TableViewCell.h"

@interface UITable2 ()


@end
@implementation UITable2
@synthesize condtion;
@synthesize categoryName;



- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Books_DataBase";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"BookName";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 100000;
    }
    return self;
}


- (void)viewDidLoad
{
    [self setTitle:self.categoryName];
    
    [super viewDidLoad];

     
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.objects.count;

}

- (PFQuery *)queryForTable
{
    
    PFQuery *SpecificBook = [PFQuery queryWithClassName:self.parseClassName];
    [SpecificBook whereKey:@"Subject" equalTo:self.categoryName];
    [SpecificBook orderByAscending:@"BookName"];
   
    if ([self.objects count] == 0) {
        SpecificBook.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    return SpecificBook;
}

//--------------------------------Table Cell formating---------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *simpleTableIdentifier = @"RecentCell";
    
    TableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    if (tableView == self.tableView) {
        
        cell.name.text = [object objectForKey:@"BookName"];
        
        cell.sub.text = [object objectForKey:@"Subject"];
        
        cell.price.text = [object objectForKey:@"Price"];
        
        cell.author.text = [NSString stringWithFormat:@"%@%@", @"by ", [object objectForKey:@"AuthorName"]];
        
        condtion = [object objectForKey:@"Condition"];
        
        NSLog(@"%@",condtion);
        
        if ([condtion isEqualToString:@"Like-New"])
        {
            //  cell.context.text = NULL;
            //cell.context.backgroundColor = [UIColor colorWithRed:(0.0/255.0) green:(132.0/255.0) blue:(0.0/255.0) alpha:0.4];
            [cell.con setImage:[UIImage imageNamed: @"Green.png"]];
            
            
        }
        
        else if ([condtion isEqualToString:@"Heavily-Used"])
        {
            [cell.con setImage:[UIImage imageNamed: @"Red.png"]];
            
            //cell.con.backgroundView = [[ UIImageView alloc] initWithImage:[ UIImage imageNamed:@"wallcell.png"]];
            
        }
        
        PFFile *theImage = [object objectForKey:@"image"];
        
        NSData *imageData = [theImage getData];
        
        //UIImage *imageview = [UIImage imageWithData:imageData];
        
        [cell.cover setImage:[UIImage imageWithData:imageData]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    cell.backgroundView = [[ UIImageView alloc] initWithImage:[ UIImage imageNamed:@"wallb.png"]];
    
    
    return cell;
}

//------------------------------------------------------------------------------------------------



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath {
    if ([segue.identifier isEqualToString:@"CatagDetail"]) {
        BooksDetailsViewController *destViewController = segue.destinationViewController;
        PFObject *object = nil;

            indexPath = [self.tableView indexPathForSelectedRow];
            object = [self.objects objectAtIndex:indexPath.row];
            destViewController.copyob = object;
        
    }
}



-(void)setCategory:(NSString *)selectedCategory{
    if(!categoryName){categoryName = selectedCategory;}
}




@end
