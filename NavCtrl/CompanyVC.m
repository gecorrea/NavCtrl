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
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.4 green:0.8 blue:0.2 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.dataManager = [DAO sharedInstance];
    self.dataManager.delegate = self;
    self.dataManager.managedObjectContext.undoManager = [[[NSUndoManager alloc] init] autorelease];
    // make undo and redo buttons hidden
    self.redoButton.hidden = YES;
    self.undoButton.hidden = YES;
    
    // Title of CompanyVC
    self.title = @"Mobile device makers";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.dataManager getCompanyData];
    [self.tableView reloadData];
    if(self.tableView.isEditing) {
        [self allowUndo];
        [self allowRedo];
    }
}

// Allow toggling of edit mode for CompanyVC.
- (void)toggleEditMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.leftBarButtonItem.title = @"Edit";
        self.redoButton.hidden = YES;
        self.undoButton.hidden = YES;
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView setAllowsSelectionDuringEditing:true];
        self.navigationItem.leftBarButtonItem.title = @"Done";
        
        // make redo and undo buttons visiable only if a redo/undo action can be done.
        [self allowRedo];
        [self allowUndo];
    }
}

- (void)toggleInsertMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    }
    else {
        InsertVC *insertViewController = [[InsertVC alloc] init];
        insertViewController.title = @"New Company";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController
         pushViewController:insertViewController
         animated:YES];
    }
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataManager.companyList count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    self.company = self.dataManager.companyList[indexPath.row];
    NSString *cellText = self.company.name;
    cellText = [cellText stringByAppendingString:@" (" ];
    cellText = [cellText stringByAppendingString:self.company.stockSymbol];
    cellText = [cellText stringByAppendingString:@")"];
    cell.textLabel.text = cellText;
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.company.logoURLString]]];
    [cell.imageView sizeToFit];
    [cell.imageView clipsToBounds];
    cell.detailTextLabel.text = self.company.price;
    
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
         [self.dataManager deletedCompanyAtIndex:indexPath.row];
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         if(self.tableView.isEditing) {
             [self allowUndo];
             [self allowRedo];
         }
         
         //call that method that hides or shows redo
         
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
    if(self.tableView.isEditing) {
        [self allowUndo];
        [self allowRedo];
    }
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.dataManager.currentIndexofCompany = indexPath.row;
    if(self.tableView.isEditing == false) {
        ProductVC *productViewController = [[ProductVC alloc]init];
        self.company = self.dataManager.companyList[indexPath.row];
        NSString *title = [self.company.name stringByAppendingString:@" Products"];
        productViewController.title = title;
        self.currentCompany = self.dataManager.companyList[indexPath.row];
        productViewController.currentCompany = self.currentCompany;
        productViewController.products = self.currentCompany.products;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController pushViewController:productViewController animated:YES];
    }
    else {
        EditVC *editViewController = [[EditVC alloc] init];
        editViewController.title = @"Edit Company";
        self.currentCompany = self.dataManager.companyList[indexPath.row];
        editViewController.currentCompany = self.currentCompany;
        editViewController.name = self.currentCompany.stockSymbol;
        editViewController.imgeURL = self.currentCompany.logoURLString;
        editViewController.editURL.hidden = YES;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil]; // Set left bar button item for view being pushed to have no text.
        [self.navigationController pushViewController:editViewController animated:YES];
    }
}

- (void)receivedNamesAndPrices {
    [self.tableView reloadData];
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
- (IBAction)redoChanges:(UIButton *)sender {
    [self.dataManager.managedObjectContext redo];
    [self.dataManager loadCoreData];
    [self.dataManager getCompanyData];
    [self allowUndo];
    if (self.dataManager.managedObjectContext.undoManager.canRedo == NO)
        self.redoButton.hidden = YES;
}

- (IBAction)undoChanges:(UIButton *)sender {
    [self.dataManager.managedObjectContext undo];
    [self.dataManager loadCoreData];
    [self.dataManager getCompanyData];
    [self allowRedo];
    if (self.dataManager.managedObjectContext.undoManager.canUndo == NO)
        self.undoButton.hidden = YES;
}

- (void)allowUndo {
    if (self.dataManager.managedObjectContext.undoManager.canUndo == YES)
        self.undoButton.hidden = NO;
}

- (void)allowRedo {
    if (self.dataManager.managedObjectContext.undoManager.canRedo == YES)
        self.redoButton.hidden = NO;
}

@end
