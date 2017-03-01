#import "Product.h"

@implementation Product

- (instancetype) initWithName:(NSString *)name andURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.name = name;
        self.image = [name stringByAppendingString:@".png"];
        self.url = url;
    }
    return self;
}

- (instancetype) initWithNewProductName:(NSString *)name andURL:(NSString *)url {
    self = [super init];
    if(self) {
        self.name = name;
        self.image = @"defaultProductImage.png";
        self.url = url;
    }
    return self;
}

@end
