#import "Company.h"

@implementation Company

- (instancetype) initWithStockSymbol:(NSString *)stockSymbol andLogoURLString:(NSString *)logoURLString{
    self = [super init];
    if (self) {
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        NSArray *AResults = [[NSArray alloc] initWithContentsOfURL:url];
//        NSString *results = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"results: %@", data);
        self.stockSymbol = stockSymbol;
        self.logoURLString = logoURLString;
    }
    return self;
}

- (instancetype) initWithNewCompanyName:(NSString *)name{
    self = [super init];
    if(self) {
        self.name = name;
        self.logoURLString = @"defaultCompanyLogo.png";
    }
    return self;
}

@end
