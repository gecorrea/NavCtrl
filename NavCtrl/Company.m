#import "Company.h"

@implementation Company

- (instancetype) initWithStockSymbol:(NSString *)stockSymbol andLogoURLString:(NSString *)logoURLString{
    self = [super init];
    if (self) {
        self.stockSymbol = stockSymbol;
        self.logoURLString = logoURLString;
        self.products = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
