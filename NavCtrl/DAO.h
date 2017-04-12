#import <Foundation/Foundation.h>
#import "Company.h"
#import <CoreData/CoreData.h>

#import "ManagedCompany+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedProduct+CoreDataProperties.h"

@protocol CompanyDelegate <NSObject>

- (void)receivedNamesAndPrices;

@end

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) id<CompanyDelegate>delegate;
@property (strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *managedCompanies;
@property NSInteger currentIndexofCompany;
@property (nonatomic, retain) NSMutableArray *dataArray;


- (void)initializeCoreData;
+ (instancetype)sharedInstance;
- (void)addCompany:(NSString *)stockSymbol andImageURL:(NSString *)imageURL;
- (void)addProduct:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url forCurrentCompany:(Company *)currentCompany;
- (void)editCompany:(NSString *)stockSymbol andImageURL:(NSString *)imageURL forCurrentCompany:(Company *)currentCompany;
- (void)editProduct:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url forCurrentCompany:(Company *)currentCompany forCurrentProduct:(Product *)currentProduct;
- (void)saveCoreData;
- (void)loadCoreData;
- (void)getCompanyData;
- (void)deletedCompanyAtIndex:(NSUInteger)indexPathRow;
- (void)deleteProductAtIndex:(NSUInteger)indexPathRow forCompany:(Company *)currentCompany;

@end
