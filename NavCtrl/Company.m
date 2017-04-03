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

- (void) dealloc {
    [_name release];
    [_stockSymbol release];
    [_logoURLString release];
    [_price release];
    [_products release];
    [super dealloc];
}

@end
