#import "ProductVC.h"

@interface ProductVC ()

@property (nonatomic, retain) DAO *dataManager;
@property (nonatomic, retain) UIBarButtonItem *editButton;

@end

@implementation ProductVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // Set title of the CompanyVC
    self.title = self.currentCompany.name;

    
    // Create and set the custom back arrow button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-navBack.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    // Create and set custom add button and add edit button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-navAdd.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleInsertMode)];
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditMode)];
    self.navigationItem.rightBarButtonItems = @[addButton, self.editButton];
    
    self.currentComapnyLogo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.currentCompany.logoURLString]]];
    [self.currentComapnyLogo sizeToFit];
    self.currentCompanyName.text = self.currentCompany.name;
    self.currentCompanyName.text = [self.currentCompanyName.text stringByAppendingString:@" (" ];
    self.currentCompanyName.text = [self.currentCompanyName.text stringByAppendingString:self.currentCompany.stockSymbol];
    self.currentCompanyName.text = [self.currentCompanyName.text stringByAppendingString:@")"];
    
    // Call shared instance of data manager from DAO
    self.dataManager = [DAO sharedInstance];
    // Initialize undoManager for managed objects
    self.dataManager.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
    // Make undo and redo buttons hidden
    self.redoButton.hidden = YES;
    self.undoButton.hidden = YES;
    
    // Will allow undo/redo if available and view is in edit mode
    [self.tableView reloadData];
    if (self.tableView.isEditing == NO) {
        [self.tableView setEditing:NO animated:YES];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Edit"];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView setAllowsSelectionDuringEditing:true];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Done"];
        
        // make redo and undo buttons visiable only if a redo/undo action can be done.
        [self allowRedo];
        [self allowUndo];
    }
    [self checkForData];
}

// Method called when addButton is pressed
- (void)toggleInsertMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        self.navigationItem.rightBarButtonItem.style = UIBarButtonSystemItemAdd;
    }
    else {
        InsertVC *insertViewController = [[InsertVC alloc] init];
        insertViewController.title = @"Add Product";
        insertViewController.currentCompany = self.currentCompany;
        CATransition* transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionReveal; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
        transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        [self.navigationController pushViewController:insertViewController animated:NO];
    }
}

// Method called when edit button is pressed
- (void)toggleEditMode {
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:YES];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Edit"];
    }
    else {
        [self.tableView setEditing:YES animated:YES];
        [self.tableView setAllowsSelectionDuringEditing:true];
        [[self.navigationItem.rightBarButtonItems objectAtIndex:[self.navigationItem.rightBarButtonItems indexOfObject:self.editButton]] setTitle:@"Done"];
        
        // make redo and undo buttons visiable only if a redo/undo action can be done.
        [self allowRedo];
        [self allowUndo];
    }
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

- (void)checkForData {
    if(self.currentCompany.products.count == 0) {
        [self.tableView setHidden:YES];
        [self.emptyStateLabel setHidden:NO];
        [self.emptyStateButton setHidden:NO];
    }
    else {
        [self.tableView setHidden:NO];
        [self.emptyStateLabel setHidden:YES];
        [self.emptyStateButton setHidden:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        [self.dataManager deleteProductAtIndex:indexPath.row forCompany:self.currentCompany];

         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.currentCompany = [self.dataManager.companyList objectAtIndex:self.dataManager.currentIndexofCompany];
        if(self.tableView.isEditing) {
            [self allowUndo];
            [self allowRedo];
        }
        [self.tableView reloadData];
        [self checkForData];
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
    
    if(self.tableView.isEditing) {
        [self allowUndo];
        [self allowRedo];
    }
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
    // Create the next detailVC
    DetailVC *detailViewController = [[DetailVC alloc] initWithNibName:@"DetailVC" bundle:nil];
    // Pass the selected object to the new view controller.
    self.product = [self.products objectAtIndex:[indexPath row]];
    NSURL *url = [NSURL URLWithString:self.product.url];
    detailViewController.url = url;
    detailViewController.currentCompany = self.currentCompany;
    self.product =[self.products objectAtIndex:[indexPath row]];
    detailViewController.currentProduct = self.product;
    detailViewController.productIndex = [indexPath row];
    // Push the view controller.
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:detailViewController animated:NO];
}

- (void)dealloc {
    [_tableView release];
    [_redoButton release];
    [_undoButton release];
    [_currentCompany release];
    [_editButton release];
    [_dataManager release];
    [_product release];
    [_products release];
    [_currentComapnyLogo release];
    [_currentCompanyName release];
    [_emptyStateLabel release];
    [_emptyStateButton release];
    [super dealloc];
}

- (IBAction)redoChanges:(UIButton *)sender {
    [self.dataManager.managedObjectContext redo];
    [self.dataManager loadCoreData];
    
    for (Company *comp in self.dataManager.companyList) {
        if ([comp.stockSymbol isEqualToString:self.currentCompany.stockSymbol]) {
            self.products = comp.products;
            [self.tableView reloadData];
        }
    }
    [self allowUndo];
    [self checkForData];
}

- (IBAction)undoChanges:(UIButton *)sender {
    [self.dataManager.managedObjectContext undo];
    [self.dataManager loadCoreData];
    self.currentCompany = [self.dataManager.companyList objectAtIndex:self.dataManager.currentIndexofCompany];
    
    for (Company *comp in self.dataManager.companyList) {
        if ([comp.stockSymbol isEqualToString:self.currentCompany.stockSymbol]) {
            self.products = comp.products;
            [self.tableView reloadData];
        }
    }
    [self allowRedo];
    [self checkForData];
}

- (IBAction)addProduct:(UIButton *)sender {
    InsertVC *insertViewController = [[InsertVC alloc] init];
    insertViewController.title = @"Add Product";
    insertViewController.currentCompany = self.currentCompany;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromBottom; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:insertViewController animated:NO];
}

- (void)allowUndo {
    if(self.dataManager.managedObjectContext.undoManager.canUndo == YES)
        self.undoButton.hidden = NO;
}

- (void)allowRedo {
    if(self.dataManager.managedObjectContext.undoManager.canRedo == YES)
        self.redoButton.hidden = NO;
}


@end
