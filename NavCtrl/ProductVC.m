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

@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toggleInsertMode)];
    self.navigationItem.rightBarButtonItem = addButton;

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
        [self.navigationController
         pushViewController:self.insertViewController
         animated:YES];
    }
}

//- (void)toggleEditMode {
//    if (self.tableView.isEditing) {
//        [self.tableView setEditing:NO animated:YES];
//        self.navigationItem.rightBarButtonItem.title = @"Edit";
//    }
//    else {
//        [self.tableView setEditing:YES animated:YES];
//        self.navigationItem.rightBarButtonItem.title = @"Done";
//    }
//}

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
    cell.imageView.image = [UIImage imageNamed:self.product.image];
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
    DetailVC *detailViewController = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
 
    // Pass the selected object to the new view controller.
    self.product = [self.products objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:self.product.url];
    detailViewController.url = url;
     
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}



- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
