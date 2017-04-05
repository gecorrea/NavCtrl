#import "EditVC.h"

@interface EditVC ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation EditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataManager = [DAO sharedInstance];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.editName.textAlignment = NSTextAlignmentCenter;
    self.editImageURL.textAlignment = NSTextAlignmentCenter;
    self.editURL.textAlignment = NSTextAlignmentCenter;
    
    self.editName.text = self.name;
    self.editImageURL.text = self.imgeURL;
    self.editURL.text = self.url;
    
    if ([self.title isEqualToString:@"Edit Product"]) {
        self.isCompany = NO;
    }
    else {
        self.isCompany = YES;
        [self.editURL setHidden:YES];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveInfo {
    if(self.isCompany == YES) {
        [self.dataManager editCompany:self.editName.text andImageURL:self.editImageURL.text forCurrentCompany:self.currentCompany];
    }
    else {
        [self.dataManager editProduct:self.editName.text andImageURL:self.editImageURL.text andURL:self.editURL.text forCurrentCompany:self.currentCompany forCurrentProduct:self.currentProduct];
    }
    [self.navigationController popViewControllerAnimated:true];
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

//- (void)dealloc {
//    [_editName release];
//    [_editImageURL release];
//    [_editURL release];
//    [super dealloc];
//}
@end
