#import <Foundation/Foundation.h>
#import "Company.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;

+ (instancetype)sharedInstance;

@end
