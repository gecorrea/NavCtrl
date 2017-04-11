#import "EditVC.h"

@interface EditVC ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation EditVC

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
    self.editName.textAlignment = NSTextAlignmentCenter;
    self.editImageURL.textAlignment = NSTextAlignmentCenter;
    self.editURL.textAlignment = NSTextAlignmentCenter;
    
    // Set the text for each text field
    self.editName.text = self.name;
    self.editImageURL.text = self.imgeURL;
    self.editURL.text = self.url;
    
    // Determine which text fields to show based on whether isCompany
    if ([self.title isEqualToString:@"Edit Product"]) {
        self.isCompany = NO;
    }
    else {
        // Hide editURL text field if isCompany is true
        self.isCompany = YES;
        [self.editURL setHidden:YES];
    }
    
    // Allows keyboard to show or be hidden if touch in text field or touch outside text field.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// Method to save the changes made
- (void) saveInfo {
    if(self.isCompany == YES) {
        [self.dataManager editCompany:self.editName.text andImageURL:self.editImageURL.text forCurrentCompany:self.currentCompany];
    }
    else {
        [self.dataManager editProduct:self.editName.text andImageURL:self.editImageURL.text andURL:self.editURL.text forCurrentCompany:self.currentCompany forCurrentProduct:self.currentProduct];
    }
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void) dealloc {
    [_dataManager release];
    [_name release];
    [_imgeURL release];
    [_url release];
    [_editName release];
    [_editImageURL release];
    [_editURL release];
    [_currentCompany release];
    [_currentProduct release];
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

- (IBAction)deleteItem:(UIButton *)sender {
    [self.dataManager deleteProductAtIndex:self.productIndex forCompany:self.currentCompany];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
