#import <Foundation/Foundation.h>
#import "Company.h"

@protocol CompanyDelegate <NSObject>

- (void)receivedNamesAndPrices;

@end

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) id<CompanyDelegate>delegate;

+ (instancetype)sharedInstance;
- (void)addName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany;
- (void)editName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany forCurrentProduct:(Product *)currentProduct;

@end
