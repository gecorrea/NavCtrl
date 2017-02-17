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

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *products;
@property (nonatomic, retain) NSArray *productImages;
@property (nonatomic, retain) NSArray *productURL;


@end
