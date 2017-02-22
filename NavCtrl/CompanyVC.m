//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"

@interface CompanyVC ()

@end

@implementation CompanyVC

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    // Do any additional setup after loading the view from its nib.
    Company *apple = [[Company alloc] initWithName:@"Apple"];
    Company *google =[[Company alloc] initWithName:@"Google"];
    Company *microsoft = [[Company alloc] initWithName:@"Microsoft"];
    Company *samsung = [[Company alloc] initWithName:@"Samsung"];
    
//    self.companyList = [[NSMutableArray alloc] initWithObjects:@"Apple mobile devices", @"Google mobile devices", @"Microsoft mobile devices", @"Samsung mobile devices", nil];
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, google, microsoft, samsung, nil];
    self.title = @"Mobile device makers";
//    self.appleProducts = [[NSMutableArray alloc]initWithObjects:@"Apple Watch", @"iPad", @"iPhone", nil];
//    self.appleImages = [[NSMutableArray alloc] initWithObjects:@"Apple Watch.png", @"iPad.png", @"iPhone.png", nil];
//    self.appleURLs = [[NSMutableArray alloc] initWithObjects:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#", @"http://www.apple.com/shop/buy-ipad/ipad-pro", @"http://www.apple.com/shop/buy-iphone/iphone-7", nil];
//    self.googleProducts = [[NSMutableArray alloc] initWithObjects:@"Pixel C", @"Daydream View",@"Pixel", nil];
//    self.googleImages = [[NSMutableArray alloc] initWithObjects:@"Pixel C.png", @"Daydream View.png", @"Pixel.png", nil];
//    self. googleURLs = [[NSMutableArray alloc] initWithObjects:@"https://store.google.com/product/pixel_c", @"https://store.google.com/product/daydream_view", @"https://store.google.com/product/pixel_phone", nil];
//    self.microsoftProducts = [[NSMutableArray alloc] initWithObjects:@"HoloLens", @"Lumia 950", @"Surface Pro 4", nil];
//    self.microsoftImages = [[NSMutableArray alloc] initWithObjects:@"HoloLens.png", @"Lumia 950.png", @"Surface Pro 4.png", nil];
//    self.microsoftURLs = [[NSMutableArray alloc] initWithObjects:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000", nil];
//    self.samsungProducts = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note", @"Galaxy S", @"Galaxy Tab", nil];;
//    self.samsungImages = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note.png", @"Galaxy S4.png", @"Galaxy Tab.png", nil];
//    self.samsungURLs = [[NSMutableArray alloc] initWithObjects:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/", @"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/", @"http://www.samsung.com/us/mobile/tablets/", nil];
}

- (void)toggleEditMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Edit";
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.rightBarButtonItem.title = @"Done";
    }
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    for (int i = 0; i <= indexPath.row; i++) {
        Company *company = self.companyList[indexPath.row];
        cell.textLabel.text = company.companyName;
        cell.imageView.image = [UIImage imageNamed:company.companyLogo];
        
//        if ([company.companyName isEqualToString:@"Apple mobile devices"]) {
//            cell.imageView.image = [UIImage imageNamed:@"AppleLogo.png"];
//        }
//        else if ([company.companyName isEqualToString:@"Google mobile devices"]) {
//            cell.imageView.image = [UIImage imageNamed:@"GoogleLogo.png"];
//        }
//        else if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Microsoft mobile devices"]) {
//        cell.imageView.image = [UIImage imageNamed:@"MicrosoftLogo.png"];
//        }
//        else {
//            cell.imageView.image = [UIImage imageNamed:@"SamsungLogo.png"];
//        }
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         // Delete the row from the data source
         [self.companyList removeObjectAtIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
}

//********************************************************************************************************************************
// Allow reordering of cells
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewCellEditingStyleNone;
//}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSString *stringToMove = self.companyList[fromIndexPath.row];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:stringToMove atIndex:toIndexPath.row];
}
//********************************************************************************************************************************

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.productViewController = [[ProductVC alloc]init];
    Company *company = self.companyList[indexPath.row];
    if ([company.companyName isEqualToString:@"Apple mobile devices"]){
        self.productViewController.title = company.companyName;
        self.productViewController.products = self.apple.product.products;
        self.productViewController.productImages = self.apple.product.images;
        self.productViewController.productURLs = self.apple.product.urls;
    }
    else if ([company.companyName isEqualToString:@"Google mobile devices"]){
        self.productViewController.title = @"Google mobile devices";
        self.productViewController.products = self.google.product.products;
        self.productViewController.productImages = self.google.product.images;
        self.productViewController.productURLs = self.google.product.urls;
        
    }
    else if ([company.companyName isEqualToString:@"Microsoft mobile devices"]){
        self.productViewController.title = @"Microsoft mobile devices";
        self.productViewController.products = self.microsoft.product.products;
        self.productViewController.productImages = self.microsoft.product.images;
        self.productViewController.productURLs = self.microsoft.product.urls;
        
    }
    else {
        self.productViewController.title = @"Samsung mobile devices";
        self.productViewController.products = self.samsung.product.products;
        self.productViewController.productImages = self.samsung.product.images;
        self.productViewController.productURLs = self.samsung.product.urls;
    }
    
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) dealloc {
    [_tableView release];
    [super dealloc];
}
@end
