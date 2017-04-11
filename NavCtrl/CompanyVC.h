#import <UIKit/UIKit.h>
#import "ProductVC.h"
#import "Company.h"
#import "DAO.h"
#import "InsertVC.h"
#import "EditVC.h"

@interface CompanyVC : UIViewController<UITableViewDelegate, UITableViewDataSource, CompanyDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Company *currentCompany;
@property (retain, nonatomic) IBOutlet UIButton *redoButton;
@property (retain, nonatomic) IBOutlet UIButton *undoButton;
@property (retain, nonatomic) IBOutlet UILabel *emptyStateLabel;
@property (retain, nonatomic) IBOutlet UIImageView *emptyStateImage;
@property (retain, nonatomic) IBOutlet UIButton *emptyStateButton;

- (IBAction)redoChanges:(UIButton *)sender;
- (IBAction)undoChanges:(UIButton *)sender;
- (IBAction)addCompany:(UIButton *)sender;

@end
