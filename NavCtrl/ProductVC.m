//
//  ProductVC.m
//  NavCtrl
//
//  Created by Jesse Sahli on 2/7/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductVC.h"

@interface ProductVC ()

@property (nonatomic, retain) DAO *dataManager;
@property (nonatomic, retain) UIBarButtonItem *editButton;

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleInsertMode)];
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItems = @[addButton, self.editButton];
    // Do any additional setup after loading the view from its nib.
    self.dataManager = [DAO sharedInstance];
}

- (void)toggleInsertMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    }
    else {
        self.insertViewController = [[InsertVC alloc] init];
        self.insertViewController.title = @"Add Product";
        self.insertViewController.currentCompany = self.currentCompany;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController pushViewController:self.insertViewController animated:YES];
    }
}

- (void)toggleEditMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Edit"];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView setAllowsSelectionDuringEditing:true];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Done"];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
//    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    self.product = [self.products objectAtIndex:[indexPath row]];
    cell.textLabel.text = self.product.name;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.product.imageURL]]];
    [cell.imageView sizeToFit];
    [cell.imageView clipsToBounds];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the specified item to be editable.
     return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    self.product = [self.products objectAtIndex:[fromIndexPath row]];
    Product *productToMove = self.product;
    [self.products removeObjectAtIndex:fromIndexPath.row];
    [self.products insertObject:productToMove atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
// Return NO if you do not want the item to be re-orderable.
return YES;
}


 #pragma mark - Table view delegate
 
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if(self.tableView.isEditing == false) {
        DetailVC *detailViewController = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
        // Pass the selected object to the new view controller.
        self.product = [self.products objectAtIndex:[indexPath row]];
        NSURL *url = [NSURL URLWithString:self.product.url];
        detailViewController.url = url;
        // Push the view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else {
        self.editViewController = [[EditVC alloc] init];
        self.editViewController.title = @"Edit Product";
        self.product = [self.products objectAtIndex:[indexPath row]];
        self.editViewController.currentCompany = self.currentCompany;
        self.editViewController.currentProduct = self.product;
        self.editViewController.name = self.product.name;
        self.editViewController.imgeURL = self.product.imageURL;
        self.editViewController.url = self.product.url;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController pushViewController:self.editViewController animated:YES];
    }
}



- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
