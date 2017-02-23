#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DetailVC : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSURL *url;

@end
