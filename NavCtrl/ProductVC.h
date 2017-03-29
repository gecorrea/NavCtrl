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
@property (nonatomic, retain) InsertVC *insertViewController;
@property (nonatomic, retain) EditVC *editViewController;
@property (retain, nonatomic) IBOutlet UIButton *redoButton;
@property (retain, nonatomic) IBOutlet UIButton *undoButton;

- (IBAction)redoChanges:(UIButton *)sender;
- (IBAction)undoChanges:(UIButton *)sender;

@end
