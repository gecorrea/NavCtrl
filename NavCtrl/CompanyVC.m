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
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleEditMode)];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    // Do any additional setup after loading the view from its nib.
    self.companyList = [[NSMutableArray alloc] initWithObjects:@"Apple mobile devices", @"Google mobile devices", @"Microsoft mobile devices", @"Samsung mobile devices", nil];
    self.companyLogo = [[NSMutableArray alloc] initWithObjects:@"AppleLogo.png", @"GoogleLogo.png", @"MicrosoftLogo.png", @"SamsungLogo.png", nil];
    self.title = @"Mobile device makers";
    self.appleProducts = [[NSMutableArray alloc]initWithObjects:@"Apple Watch", @"iPad", @"iPhone", nil];
    self.appleImages = [[NSMutableArray alloc] initWithObjects:@"Apple Watch.png", @"iPad.png", @"iPhone.png", nil];
    self.appleURLs = [[NSMutableArray alloc] initWithObjects:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#", @"http://www.apple.com/shop/buy-ipad/ipad-pro", @"http://www.apple.com/shop/buy-iphone/iphone-7", nil];
    self.googleProducts = [[NSMutableArray alloc] initWithObjects:@"Pixel C", @"Daydream View",@"Pixel", nil];
    self.googleImages = [[NSMutableArray alloc] initWithObjects:@"Pixel C.png", @"Daydream View.png", @"Pixel.png", nil];
    self. googleURLs = [[NSMutableArray alloc] initWithObjects:@"https://store.google.com/product/pixel_c", @"https://store.google.com/product/daydream_view", @"https://store.google.com/product/pixel_phone", nil];
    self.microsoftProducts = [[NSMutableArray alloc] initWithObjects:@"HoloLens", @"Lumia 950", @"Surface Pro 4", nil];
    self.microsoftImages = [[NSMutableArray alloc] initWithObjects:@"HoloLens.png", @"Lumia 950.png", @"Surface Pro 4.png", nil];
    self.microsoftURLs = [[NSMutableArray alloc] initWithObjects:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000", nil];
    self.samsungProducts = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note", @"Galaxy S", @"Galaxy Tab", nil];;
    self.samsungImages = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note.png", @"Galaxy S4.png", @"Galaxy Tab.png", nil];
    self.samsungURLs = [[NSMutableArray alloc] initWithObjects:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/", @"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/", @"http://www.samsung.com/us/mobile/tablets/", nil];
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
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    cell.imageView.image = [UIImage imageNamed:self.companyLogo[[indexPath row]]];
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
         [self.companyLogo removeObjectAtIndex:indexPath.row];
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
        [self.companyList exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        [self.companyLogo exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}
//********************************************************************************************************************************

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.productViewController = [[ProductVC alloc]init];
    if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Apple mobile devices"]){
        self.productViewController.title = @"Apple mobile devices";
        self.productViewController.products = self.appleProducts;
        self.productViewController.productImages = self.appleImages;
        self.productViewController.productURL = self.appleURLs;
    }
    else if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Google mobile devices"]){
        self.productViewController.title = @"Google mobile devices";
        self.productViewController.products = self.googleProducts;
        self.productViewController.productImages = self.googleImages;
        self.productViewController.productURL = self.googleURLs;
        
    }
    else if ([[self.companyList objectAtIndex:[indexPath row]] isEqualToString:@"Microsoft mobile devices"]){
        self.productViewController.title = @"Microsoft mobile devices";
        self.productViewController.products = self.microsoftProducts;
        self.productViewController.productImages = self.microsoftImages;
        self.productViewController.productURL = self.microsoftURLs;
        
    }
    else {
        self.productViewController.title = @"Samsung mobile devices";
        self.productViewController.products = self.samsungProducts;
        self.productViewController.productImages = self.samsungImages;
        self.productViewController.productURL = self.samsungURLs;
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
