//
//  EditVC.h
//  NavCtrl
//
//  Created by Aditya Narayan on 3/2/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface EditVC : UIViewController

@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *imgeURL;
@property (retain, nonatomic) NSString *url;
@property (retain, nonatomic) IBOutlet UITextField *editName;
@property (retain, nonatomic) IBOutlet UITextField *editImageURL;
@property (retain, nonatomic) IBOutlet UITextField *editURL;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic) BOOL isCompany;
@property (nonatomic, retain) Product *currentProduct;

@end
