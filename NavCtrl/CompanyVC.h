//
//  CompanyVC.h
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "Company.h"
#import "DAO.h"
#import "InsertVC.h"
#import "EditVC.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource, CompanyDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) InsertVC *insertViewController;
@property (nonatomic, retain) EditVC *editViewController;

@end
