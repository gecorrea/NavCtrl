#import <UIKit/UIKit.h>
#import "DAO.h"

@interface InsertVC : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *insertName;
@property (nonatomic, retain) IBOutlet UITextField *insertImageURL;
@property (nonatomic, retain) IBOutlet UITextField *insertURL;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic) BOOL isCompany;

@end
