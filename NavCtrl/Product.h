//
//  Product.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *url;

- (instancetype) initWithName: (NSString *)name;

@end
