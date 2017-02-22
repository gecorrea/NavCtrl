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
