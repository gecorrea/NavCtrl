#import "Company.h"

@implementation Company

- (instancetype) initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.logo = [name stringByAppendingString:@"Logo.png"];
    }
    return self;
}

- (instancetype) initWithNewCompanyName:(NSString *)name {
    self = [super init];
    if(self) {
        self.name = name;
        self.logo = @"defaultCompanyLogo.png";
    }
    return self;
}

@end
