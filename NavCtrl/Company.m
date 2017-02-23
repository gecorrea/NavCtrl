#import "Company.h"

@implementation Company

- (instancetype) initWithName: (NSString *)name {
    self = [super init];
    if (self) {
        self.name = [name stringByAppendingString:@" Mobile Devices"];
        self.logo = [name stringByAppendingString:@"Logo.png"];
    }
    return self;
}

@end
