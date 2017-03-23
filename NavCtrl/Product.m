#import "Product.h"

@implementation Product

- (instancetype) initWithName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url {
    self = [super init];
    if (self) {
        self.name = name;
        self.imageURL = imageURL;
        self.url = url;
    }
    return self;
}

@end
