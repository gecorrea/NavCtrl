#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *url;

- (instancetype) initWithName: (NSString *)name andURL: (NSString *)url;

@end
