#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Company.h"
#import "EditVC.h"

@interface DetailVC : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSURL *url;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) Product *currentProduct;
@property NSUInteger productIndex;

@end
