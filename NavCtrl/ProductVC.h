//
//  ProductVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailVC.h"
#import <WebKit/WebKit.h>
#import "Product.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *productImages;
@property (nonatomic, retain) NSMutableArray *productURLs;
@property (nonatomic, retain) Product *product;

@end
