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
//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, strong) NSString *stockSymbol;
//@property (nonatomic, strong) NSString *logoURL;
//@property (nonatomic, strong) NSString *price;


- (void)initializeCoreData;
+ (instancetype)sharedInstance;
- (void)addName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany;
- (void)editName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany forCurrentProduct:(Product *)currentProduct;

@end
