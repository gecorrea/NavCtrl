//
//  InsertVC.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/27/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "InsertVC.h"

@interface InsertVC ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation InsertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataManager = [DAO sharedInstance];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.insertName.textAlignment = NSTextAlignmentCenter;
    self.insertURL.textAlignment = NSTextAlignmentCenter;
    self.insertImageURL.textAlignment = NSTextAlignmentCenter;
    self.insertName.placeholder = @"Insert Name";
    if ([self.title isEqualToString:@"Add Product"]) {
        self.insertImageURL.placeholder = @"Insert Image URL";
        self.insertURL.placeholder = @"Insert URL";
        self.isCompany = NO;
    }
    else {
        [self.insertImageURL isHidden];
        [self.insertURL isHidden];
        self.isCompany = YES;
    }
}

- (void) saveInfo {
    if(self.isCompany == YES){
//        for (Company *company in self.dataManager.companyList) {
//            if([company.name isEqualToString:self.name]) {
//                [self showSimpleAlert];
//                break;
//            }
//        }
            [self.dataManager addName:self.insertName.text andImageURL:self.insertImageURL.text andURL:self.insertURL.text isCompany:self.isCompany forCurrentCompany:nil];
    }
    else {
//        for (Product *product in self.dataManager.products) {
//            if([product.name isEqualToString:self.name]) {
//                [self showSimpleAlert];
//                break;
//            }
//            else {
                [self.dataManager addName:self.insertName.text andImageURL:self.insertImageURL.text andURL:self.insertURL.text isCompany:self.isCompany forCurrentCompany:self.currentCompany];
//            }
//        }
    }
    [self.navigationController popViewControllerAnimated:true];
}

// Hides keyboard when tap out of text field.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showSimpleAlert {
    NSString *title = NSLocalizedString(@"ERROR", nil);
    NSString *message = NSLocalizedString(@"Company or product was not added because it already exist.", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the action.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The simple alert's cancel action occured.");
    }];
    
    // Add the action.
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
