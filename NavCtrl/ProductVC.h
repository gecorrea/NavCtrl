#import <UIKit/UIKit.h>
#import "DetailVC.h"
#import <WebKit/WebKit.h>
#import "DAO.h"
#import "InsertVC.h"
#import "EditVC.h"

@interface ProductVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) Product *product;
@property (retain, nonatomic) IBOutlet UIButton *redoButton;
@property (retain, nonatomic) IBOutlet UIButton *undoButton;
@property (retain, nonatomic) IBOutlet UIImageView *currentComapnyLogo;
@property (retain, nonatomic) IBOutlet UILabel *currentCompanyName;
@property (retain, nonatomic) IBOutlet UILabel *emptyStateLabel;
@property (retain, nonatomic) IBOutlet UIButton *emptyStateButton;

- (IBAction)redoChanges:(UIButton *)sender;
- (IBAction)undoChanges:(UIButton *)sender;

- (IBAction)addProduct:(UIButton *)sender;

@end
