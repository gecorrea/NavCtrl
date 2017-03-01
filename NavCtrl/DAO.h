#import <Foundation/Foundation.h>
#import "Company.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;

+ (instancetype)sharedInstance;
- (void)addName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany;

@end
