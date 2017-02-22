//
//  Company.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *companyLogo;
@property (nonatomic, retain) NSMutableArray *products;
//@property (nonatomic, retain) NSMutableArray *products;
//@property (nonatomic, retain) NSMutableArray *images;
//@property (nonatomic, retain) NSMutableArray *urls;

//- (instancetype) initWithProductInfo: (NSString *)company;

- (instancetype) initWithName: (NSString *)name;

@end
