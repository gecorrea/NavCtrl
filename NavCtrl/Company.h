#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSMutableArray *products;

- (instancetype) initWithName:(NSString *)name;
- (instancetype) initWithNewCompanyName:(NSString *)name;

@end
