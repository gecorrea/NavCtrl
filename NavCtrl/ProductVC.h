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
#import "DAO.h"
#import "InsertVC.h"
#import "EditVC.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) InsertVC *insertViewController;
@property (nonatomic, retain) EditVC *editViewController;

@end
