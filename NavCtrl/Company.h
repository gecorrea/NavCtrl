#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *stockSymbol;
@property (nonatomic, retain) NSString *logoURLString;
@property (nonatomic, retain) NSString *price;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSString *ticker;

- (instancetype) initWithStockSymbol:(NSString *)stockSymbol andLogoURLString:(NSString *)logoURLString;
- (instancetype) initWithNewCompanyName:(NSString *)name;

@end
