//
//  BooksDetailsViewController.m
//  book
//
//  Created by E on 6/4/14.
//  Copyright (c) 2014 E. All rights reserved.
//

#import "BooksDetailsViewController.h"

@interface BooksDetailsViewController ()
{
    
}
@end

@implementation BooksDetailsViewController
@synthesize bookname,cover,author,price,copyob,condi,scroll,back;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
 //  self.tabBarController.tabBar.hidden=YES;

    //[self.navigationController setNavigationBarHidden:YES];

    [scroll setScrollEnabled:YES];
    [scroll setContentSize:CGSizeMake(300, 850)];

    bookname.text = [copyob objectForKey:@"BookName"];
    
    price.text = [copyob objectForKey:@"Price"];
    
    author.text = [NSString stringWithFormat:@"%@%@", @"by ", [copyob objectForKey:@"AuthorName"]];
    
    condi.text = [copyob objectForKey:@"Condition"];


    PFFile *theImage = [copyob objectForKey:@"image"];
    
    NSData *imageData = [theImage getData];
    
    if (!theImage)
        [cover setImage:[UIImage imageNamed:@"green.png"]];

    

    [cover setImage:[UIImage imageWithData:imageData]];
    
    
    
    back.backgroundColor = [ BooksDetailsViewController isWallPixel:cover.image :200  : 120 ];
    
    
    
    
   // [ BooksDetailsViewController isWallPixel:cover.image :11  :12 ]  ;

    [super viewDidLoad];

    // Do any additional setup after loading the view.
}




+ (UIColor *)isWallPixel: (UIImage *)image :(int) x :(int) y {
    
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    const UInt8* data = CFDataGetBytePtr(pixelData);
    
    int pixelInfo = ((image.size.width  * y) + x ) * 4; 
    
    UInt8 red = data[pixelInfo];
    UInt8 green = data[(pixelInfo + 1)];
    UInt8 blue = data[pixelInfo + 2];
    UInt8 alpha = data[pixelInfo + 3];
    CFRelease(pixelData);
    
    UIColor* color = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f]; // The pixel color info
    
    return color;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


        


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
