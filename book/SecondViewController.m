//
//  SecondViewController.m
//  book
//
//  Created by E on 6/3/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "SecondViewController.h"
#import "UITable2.h"


@interface SecondViewController ()

@property NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

+(NSArray*)allCategories{
    NSArray *allCats = [NSArray arrayWithObjects:@"Accounting",@"Administration of Justice",@"Anthropology",@"Arts",@"Astronomy",@"Automotive Technology",@"Biology",@"Business",@"Cantonese",@"Career Life Planning",@"Chemistry",@"Child Development",@"Computer Aided Design",@"Computer Information System",@"Counseling",@"Dance",@"Economics",@"Education",@"Engeineering",@"ESL",@"English",@"Enviromental Science",@"Film and Television",@"French",@"Geography",@"Geology",@"German",@"Guidance",@"Health Technology",@"Health",@"Hindi",@"History",@"Human Development",@"Humanities",@"Intercultural Studies",@"International Studies",@"Italian",@"Japanese",@"Journalism",@"Korean",@"Language Arts",@"Learning Assistance",@"Librarty",@"Linguistics",@"Mandarin",@"Manufacturing",@"Mathematics",@"Meterology",@"Music",@"Nursing",@"Nutrition",@"Paralegal",@"Persian",@"Philosophy",@"Photography",@"Physical Education",@"Physics",@"Political Science",@"Pyschology",@"Reading",@"Real Estate",@"Russian",@"Sign Language",@"Skills",@"Social Science",@"Sociology",@"Spanish",@"Speech",@"Theater Arts",@"Vietnamese",@"Women Studies",@"Misc", nil];
    return allCats;
}

- (void)viewDidLoad
{
    self.categories = [SecondViewController allCategories];
    PFUser *x = [PFUser currentUser];
    
    
    NSLog(@"%@",x.username);
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"LoginScreen" sender:self];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
    // [self.myTableView reloadData];
    
    
    
}

- (IBAction)logoutButtonClicked:(id)sender {
    
    [PFUser logOut];
    if (![PFUser currentUser]) {
        
        [self performSegueWithIdentifier:@"LoginScreen" sender:self];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *categoryCell = @"categoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryCell];
    }
    
    cell.textLabel.text = [self.categories objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"Catag"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"%@",[self.categories objectAtIndex:indexPath.row]);
        [[segue destinationViewController] setCategoryName:[self.categories objectAtIndex:indexPath.row]];
    }
}


@end
