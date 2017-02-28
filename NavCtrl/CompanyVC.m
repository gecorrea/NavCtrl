//
//  CompanyVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyVC.h"

@interface CompanyVC ()

@property (nonatomic, retain) DAO *dataManager;

@end

@implementation CompanyVC

- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.leftBarButtonItem = editButton;
    UIBarButtonItem *insertButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleInsertMode)];
    self.navigationItem.rightBarButtonItem = insertButton;
    
    self.dataManager = [DAO sharedInstance];
    
    // Title of CompanyVC
    self.title = @"Mobile device makers";
}

// Allow toggling of edit mode for CompanyVC.
- (void)toggleEditMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Done";
    }
}

- (void)toggleInsertMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    }
    else {
        self.insertViewController = [[InsertVC alloc] init];
        self.insertViewController.title = @"Add Company";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController
         pushViewController:self.insertViewController
         animated:YES];
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
    return [self.dataManager.companyList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    self.company = self.dataManager.companyList[indexPath.row];
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
         [self.dataManager.companyList removeObjectAtIndex:indexPath.row];
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
    self.company = self.dataManager.companyList[fromIndexPath.row];
    Company *companyToMove = self.company;
    [self.dataManager.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.dataManager.companyList insertObject:companyToMove atIndex:toIndexPath.row];
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.productViewController = [[ProductVC alloc]init];
    self.company = self.dataManager.companyList[indexPath.row];
    self.productViewController.title = self.company.name;
    Company *currentCompany = self.dataManager.companyList[indexPath.row];
    self.productViewController.products = currentCompany.products;
    
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
