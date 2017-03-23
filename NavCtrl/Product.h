#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *url;

- (instancetype) initWithName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url;

@end
