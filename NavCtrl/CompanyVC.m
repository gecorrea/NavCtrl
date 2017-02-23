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
    // Do any additional setup after loading the view from its nib.
    
    // Display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    // Create companies
    Company *apple = [[Company alloc] initWithName:@"Apple"];
    Company *google = [[Company alloc] initWithName:@"Google"];
    Company *microsoft = [[Company alloc] initWithName:@"Microsoft"];
    Company *samsung = [[Company alloc] initWithName:@"Samsung"];

    // Create products
    Product *appleWatch = [[Product alloc] initWithName:@"Apple Watch" andURL:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#"];
    Product *iPad = [[Product alloc] initWithName:@"iPad" andURL:@"http://www.apple.com/shop/buy-ipad/ipad-pro"];
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andURL:@"http://www.apple.com/shop/buy-iphone/iphone-7"];
    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andURL:@"https://store.google.com/product/pixel_c"];
    Product *daydreamView = [[Product alloc] initWithName:@"Daydream View" andURL:@"https://store.google.com/product/daydream_view"];
    Product *pixel = [[Product alloc] initWithName:@"Pixel" andURL:@"https://store.google.com/product/pixel_phone"];
    Product *holoLens = [[Product alloc] initWithName:@"HoloLens" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800"];
    Product *lumia950 = [[Product alloc] initWithName:@"Lumia 950" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600"];
    Product *surfacePro4 = [[Product alloc] initWithName:@"Surface Pro 4" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000"];
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"];
    Product *galaxyS = [[Product alloc] initWithName:@"Galaxy S" andURL:@"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/"];
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" andURL:@"http://www.samsung.com/us/mobile/tablets/"];

    // Create an array of companies.
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, google, microsoft, samsung, nil];
    
    // Creat arrays of products by company
    apple.products = [[NSMutableArray alloc] initWithObjects:appleWatch, iPad, iPhone, nil];
    google.products = [[NSMutableArray alloc] initWithObjects:pixelC, daydreamView, pixel, nil];
    microsoft.products = [[NSMutableArray alloc] initWithObjects:holoLens, lumia950, surfacePro4, nil];
    samsung.products = [[NSMutableArray alloc] initWithObjects:galaxyNote, galaxyS, galaxyTab, nil];
    
    // Title of CompanyVC
    self.title = @"Mobile device makers";
}

// Allow toggling of edit mode for CompanyVC.
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
    self.company = self.companyList[indexPath.row];
    cell.textLabel.text = self.company.name;
    cell.imageView.image = [UIImage imageNamed:self.company.logo];
    
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

// Allow reordering of cells
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    self.company = self.companyList[fromIndexPath.row];
    Company *companyToMove = self.company;
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:companyToMove atIndex:toIndexPath.row];
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.productViewController = [[ProductVC alloc]init];
    self.company = self.companyList[indexPath.row];
    self.productViewController.title = self.company.name;
    self.productViewController.products = self.company.products;
    
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
