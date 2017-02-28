//
//  InsertVC.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/27/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "InsertVC.h"

@interface InsertVC ()

@end

@implementation InsertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    self.insertName.textAlignment = NSTextAlignmentCenter;
    self.insertURL.textAlignment = NSTextAlignmentCenter;
    self.insertImageURL.textAlignment = NSTextAlignmentCenter;
    self.insertName.placeholder = @"Insert Name";
    self.insertImageURL.placeholder = @"Insert Image URL";
    if ([self.title isEqualToString:@"Add Product"]) {
        self.insertURL.placeholder = @"Insert URL";
    }
    else {
        [self.insertURL isHidden];
    }
    self.name = self.insertName.text;
    self.imageURL = self.insertImageURL.text;
    self.url = self.insertURL.text;
}

- (void) saveInfo {
    
}

// Hides keyboard when tap out of text field.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
