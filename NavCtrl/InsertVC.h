//
//  InsertVC.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/27/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface InsertVC : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *insertName;
@property (nonatomic, retain) IBOutlet UITextField *insertImageURL;
@property (nonatomic, retain) IBOutlet UITextField *insertURL;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *imageURL;

@end
