//
//  UITable.m
//  book
//
//  Created by E on 6/7/14.
//  Copyright (c) 2014 E. All rights reserved.
//

#import "UITable.h"
#import "BooksDetailsViewController.h"
#include "TableViewCell.h"

@interface UITable () <UISearchDisplayDelegate, UISearchBarDelegate> {
}

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSString *name;

@end

@implementation UITable
@synthesize condtion;


- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        self.parseClassName = @"Books_DataBase";
        
        self.textKey = @"BookName";
        
        self.pullToRefreshEnabled = YES;
        
        self.paginationEnabled = YES;
        
        self.objectsPerPage = 100000;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    self.tableView.tableHeaderView = self.searchBar;
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    CGPoint offset = CGPointMake(0, self.searchBar.frame.size.height);
    self.tableView.contentOffset = offset;
    self.searchResults = [NSMutableArray array];
    _searchBar.delegate =self;
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

-(void)filterResults:(NSString *)searchTerm {

    PFQuery *query = [PFQuery queryWithClassName: @"Books_DataBase"]; // tábla amiben keres
    [query whereKey:@"BookName" containsString:searchTerm];
    NSArray *results = [query findObjects];
    [self.searchResults addObjectsFromArray:results];
    [self.searchDisplayController.searchResultsTableView reloadData];
}



-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self.searchResults removeAllObjects];

    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    [self filterResults:searchBar.text];
    [self.searchDisplayController.searchResultsTableView reloadData];    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.objects.count;
    } else {
        return self.searchResults.count;
    }
}
- (void)callbackLoadObjectsFromParse:(NSArray *)result error:(NSError *)error {
    if (!error) {
        [self.searchResults removeAllObjects];
        [self.searchResults addObjectsFromArray:result];
        [self.searchDisplayController.searchResultsTableView reloadData];
    } else {
        NSLog(@"ERROR %@,%@",error,[error userInfo]);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (PFQuery *)queryForTable
{
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query orderByDescending:@"createdAt"];
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    return query;
}



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
    
    else if(tableView == self.searchDisplayController.searchResultsTableView) {
        PFObject *searchedUser = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [searchedUser objectForKey:@"BookName"];
    }
    
    
    cell.backgroundView = [[ UIImageView alloc] initWithImage:[ UIImage imageNamed:@"wallb.png"]];

    
    return cell;
}

- (void) objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    
    NSLog(@"error: %@", [error localizedDescription]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        BooksDetailsViewController *destViewController = segue.destinationViewController;
        PFObject *object = nil;
        
        if ([self.searchDisplayController isActive]) {
            
            object = [self.searchResults objectAtIndex:indexPath.row];
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            
        }
        else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            object = [self.objects objectAtIndex:indexPath.row];
        }
        
        destViewController.copyob = object;
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
    

           
        
    [self performSegueWithIdentifier: @"ShowDetail" sender: indexPath];

    
    }
    
}





@end
