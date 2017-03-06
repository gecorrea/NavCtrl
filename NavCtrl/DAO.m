#import "DAO.h"

@implementation DAO


+ (instancetype)sharedInstance {
    static DAO *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void) loadData {
    // Create companies
    Company *apple = [[Company alloc] initWithName:@"Apple"];
    Company *google = [[Company alloc] initWithName:@"Google"];
    Company *microsoft = [[Company alloc] initWithName:@"Microsoft"];
    Company *samsung = [[Company alloc] initWithName:@"Samsung"];
    
    // Create products
    Product *appleWatch = [[Product alloc] initWithName:@"Apple Watch" andURL:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#"];
    Product *iPad = [[Product alloc] initWithName:@"iPad" andURL:@"http://www.apple.com/shop/buy-ipad/ipad-pro"];
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andURL:@"http://www.apple.com/shop/buy-iphone/iphone-7"];
    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andURL:@"https://store.google.com/product/pixel_c"];
    Product *daydreamView = [[Product alloc] initWithName:@"Daydream View" andURL:@"https://store.google.com/product/daydream_view"];
    Product *pixel = [[Product alloc] initWithName:@"Pixel" andURL:@"https://store.google.com/product/pixel_phone"];
    Product *holoLens = [[Product alloc] initWithName:@"HoloLens" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800"];
    Product *lumia950 = [[Product alloc] initWithName:@"Lumia 950" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600"];
    Product *surfacePro4 = [[Product alloc] initWithName:@"Surface Pro 4" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000"];
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"];
    Product *galaxyS = [[Product alloc] initWithName:@"Galaxy S" andURL:@"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/"];
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" andURL:@"http://www.samsung.com/us/mobile/tablets/"];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, google, microsoft, samsung, nil];
    
    // Create arrays of products by company
    apple.products = [[NSMutableArray alloc] initWithObjects:appleWatch, iPad, iPhone, nil];
    google.products = [[NSMutableArray alloc] initWithObjects:pixelC, daydreamView, pixel, nil];
    microsoft.products = [[NSMutableArray alloc] initWithObjects:holoLens, lumia950, surfacePro4, nil];
    samsung.products = [[NSMutableArray alloc] initWithObjects:galaxyNote, galaxyS, galaxyTab, nil];
}

- (void)addName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany {
    if(isCompany == YES) {
        Company *newCompany = [[Company alloc] initWithNewCompanyName:name];
        [self.companyList addObject:newCompany];
    }
    else {
        Product *newProduct = [[Product alloc] initWithNewProductName:name andURL:url];
        [[[self.companyList objectAtIndex:[self.companyList indexOfObject:currentCompany]] products] addObject:newProduct];
        
    }
}

- (void)editName:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url isCompany:(BOOL)isCompany forCurrentCompany:(Company *)currentCompany forCurrentProduct:(Product *)currentProduct {
    if(isCompany == YES) {
        Company *companyToEdit = [self.companyList objectAtIndex:[self.companyList indexOfObject:currentCompany]];
        companyToEdit.name = name;
        companyToEdit.logo = imageURL;
    }
    else {
        Product *productToEdit = [[[self.companyList objectAtIndex:[self.companyList indexOfObject:currentCompany]] products] objectAtIndex:[self.products indexOfObject:currentProduct]];
        productToEdit.name = name;
        productToEdit.image = imageURL;
        productToEdit.url = url;
    }
    
}



//- (void)dealloc {
//    // Should never be called, but just here for clarity really.
//    [self.someProperty release];
//    [super dealloc];
//}

@end
