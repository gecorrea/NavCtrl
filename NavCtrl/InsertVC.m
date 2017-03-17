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
    if ([self.title isEqualToString:@"Add Product"]) {
        self.insertName.placeholder = @"Insert Product Name";
        self.insertImageURL.placeholder = @"Insert Image URL";
        self.insertURL.placeholder = @"Insert URL";
        self.isCompany = NO;
    }
    else {
        self.insertName.placeholder = @"Insert Company Stock Symbol";
        self.insertImageURL.placeholder = @"Insert Company Logo URL";
        [self.insertURL isHidden];
        self.isCompany = YES;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)saveInfo {
//    if ([self checkIfDuplicate] == false) {
         [self.dataManager addName:self.insertName.text andImageURL:self.insertImageURL.text andURL:self.insertURL.text isCompany:self.isCompany forCurrentCompany:self.currentCompany];
//    }
    [self.navigationController popViewControllerAnimated:true];
}

//- (BOOL)checkIfDuplicate {
//    
//    switch (<#expression#>) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
//    if(self.isCompany == YES) {
//        for (Company *company in self.dataManager.companyList) {
//            if([company.stockSymbol isEqualToString:self.insertName.text]) {
//                [self showSimpleAlert];
//                return true;
//            }
//            else {
//                return false;
//            }
//        }
//    }
//    else {
//        for (Product *product in self.currentCompany.products) {
//            if([product.name isEqualToString:self.insertName.text]) {
//                [self showSimpleAlert];
//                return true;
//            }
//            else {
//                return false;
//            }
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = -50; // tweak here to adjust the moving position
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = 0; // tweak here to adjust the moving position
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
    
}

// Hides keyboard when tap out of text field.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
