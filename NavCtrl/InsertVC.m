#import "InsertVC.h"

@interface InsertVC ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation InsertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Call shared instance of data manager from DAO
    self.dataManager = [DAO sharedInstance];
    
    // Create and set the custom back arrow button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-navBack.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // Create and set the save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // Set the text alignment to the center of each text field
    self.insertName.textAlignment = NSTextAlignmentCenter;
    self.insertURL.textAlignment = NSTextAlignmentCenter;
    self.insertImageURL.textAlignment = NSTextAlignmentCenter;
    
    // Determine which text fields to show based on Nav Ctrl title and set isComapny
    // Add placeholder text to text fields
    if ([self.title isEqualToString:@"Add Product"]) {
        self.insertName.placeholder = @"Insert Product Name";
        self.insertImageURL.placeholder = @"Insert Image URL";
        self.insertURL.placeholder = @"Insert URL";
        self.isCompany = NO;
    }
    else {
        self.insertName.placeholder = @"Insert Company Stock Symbol";
        self.insertImageURL.placeholder = @"Insert Company Logo URL";
        [self.insertURL setHidden:YES];
        self.isCompany = YES;
    }
    
    // Allows keyboard to show or be hidden if touch in text field or touch outside text field.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

// Method to go back to previous VC
- (void)backButtonPressed {
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

// Method to start checking if info can be saved
- (void)saveInfo {
    BOOL isDuplicate = NO;
    if (self.isCompany == YES) {
        isDuplicate = [self checkIfDuplicateCompany:self.insertName.text];
        if (isDuplicate == NO) {
            [self saveCompany];
        }
    }
    else {
        isDuplicate = [self checkIfDuplicateProduct:self.insertName.text forCompany:self.currentCompany];
        if (isDuplicate == NO) {
            [self saveProduct];
        }
    }
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

// Method to check if company is a duplicate
- (BOOL)checkIfDuplicateCompany:(NSString *)name {
    BOOL returnValue = NO;
    for (Company *company in self.dataManager.companyList) {
        if ([company.stockSymbol isEqualToString:name]){
            [self showSimpleAlert];
            returnValue = YES;
            break;
        }
        else {
            returnValue = NO;
        }
    }
    return returnValue;
}

// Method to check if product is a duplicate
- (BOOL)checkIfDuplicateProduct:(NSString *)name forCompany:(Company *)company {
    BOOL returnValue = NO;
    for (Product *product in company.products) {
        if ([product.name isEqualToString:name]) {
            [self showSimpleAlert];
            returnValue = YES;
            break;
        }
        else {
            returnValue = NO;
        }
    }
    return returnValue;
}

// Method to save company
- (void)saveCompany {
    [self.dataManager addCompany:self.insertName.text andImageURL:self.insertImageURL.text];
}

// Method to save product
- (void)saveProduct {
    [self.dataManager addProduct:self.insertName.text andImageURL:self.insertImageURL.text andURL:self.insertURL.text forCurrentCompany:self.currentCompany];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = -50; // Tweak here to adjust the moving position
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y = 0; // Tweak here to adjust the moving position
         [self.view setFrame:newFrame];
         
     }completion:^(BOOL finished)
     {
         
     }];
}

// Hides keyboard when tap out of text field.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// Alert that is show if info entered is a duplicate
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

- (void) dealloc {
    [_dataManager release];
    [_insertName release];
    [_insertImageURL release];
    [_insertURL release];
    [_currentCompany release];
    [super dealloc];
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
