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

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *companyList;
//@property (nonatomic, retain) NSMutableArray *companyLogo;
@property (nonatomic, retain) ProductVC *productViewController;
//@property (nonatomic, retain) NSMutableArray *appleProducts;
//@property (nonatomic, retain) NSMutableArray *appleImages;
//@property (nonatomic, retain) NSMutableArray *appleURLs;
//@property (nonatomic, retain) NSMutableArray *googleProducts;
//@property (nonatomic, retain) NSMutableArray *googleImages;
//@property (nonatomic, retain) NSMutableArray *googleURLs;
//@property (nonatomic, retain) NSMutableArray *microsoftProducts;
//@property (nonatomic, retain) NSMutableArray *microsoftImages;
//@property (nonatomic, retain) NSMutableArray *microsoftURLs;
//@property (nonatomic, retain) NSMutableArray *samsungProducts;
//@property (nonatomic, retain) NSMutableArray *samsungImages;
//@property (nonatomic, retain) NSMutableArray *samsungURLs;

@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) Product *appleWatch;
@property (nonatomic, retain) Product *iPad;
@property (nonatomic, retain) Product *iPhone;
@property (nonatomic, retain) Product *pixelC;
@property (nonatomic, retain) Product *daydreamView;
@property (nonatomic, retain) Product *pixel;
@property (nonatomic, retain) Product *holoLens;
@property (nonatomic, retain) Product *lumia950;
@property (nonatomic, retain) Product *surfacePro4;
@property (nonatomic, retain) Product *galaxyNote;
@property (nonatomic, retain) Product *galaxyS;
@property (nonatomic, retain) Product *galaxyTab;

@end
