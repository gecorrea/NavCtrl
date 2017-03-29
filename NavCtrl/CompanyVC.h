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
@property (nonatomic, retain) ProductVC *productViewController;
@property (nonatomic, retain) InsertVC *insertViewController;
@property (nonatomic, retain) EditVC *editViewController;
@property (retain, nonatomic) IBOutlet UIButton *redoButton;
@property (retain, nonatomic) IBOutlet UIButton *undoButton;

- (IBAction)redoChanges:(UIButton *)sender;
- (IBAction)undoChanges:(UIButton *)sender;

@end
