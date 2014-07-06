//
//  BOOK.h
//  book
//
//  Created by David Phan on 6/19/14.
//  Copyright (c) 2014 David Phan. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

@interface HoldBooks : NSObject

@property (strong) NSString *bookName;
@property (strong) NSString *author;
@property (strong) NSString *price;
@property (strong) NSString *subject;
@property (strong) NSString *condition;
@property (strong) PFImageView *picture;


@end
