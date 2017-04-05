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
        [self initializeCoreData];
        
        BOOL hasRan = [[NSUserDefaults standardUserDefaults]boolForKey:@"hasRun"];
        // If app first run
        if (!hasRan) {
            [self loadData];
            [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"hasRun"];
        }
        else {
        // Else fetch from core data
            [self loadCoreData];
        }
        
        [self getCompanyData];
    }
    return self;
}

- (void) loadData {
    // Create companies
    Company *apple = [[Company alloc] initWithStockSymbol:@"AAPL" andLogoURLString:@"https://cdn1.iconfinder.com/data/icons/company-identity/100/apple-classic-logo-vector-128.png"];
    Company *google = [[Company alloc] initWithStockSymbol:@"GOOG" andLogoURLString:@"https://cdn1.iconfinder.com/data/icons/company-identity/100/new-google-favicon-128.png"];
    Company *microsoft = [[Company alloc] initWithStockSymbol:@"MSFT" andLogoURLString:@"https://cdn2.iconfinder.com/data/icons/social-icons-color/512/windows-128.png"];
    Company *samsung = [[Company alloc] initWithStockSymbol:@"SSNLF" andLogoURLString:@"https://cdn4.iconfinder.com/data/icons/flat-brand-logo-2/512/samsung-128.png"];
    
    // Create products
    Product *appleWatch = [[Product alloc] initWithName:@"Apple Watch" andImageURL:@"https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/2/up/2up/alu/2up-alu-silver-nylon-pearl-select_GEO_US?wid=470&hei=556&fmt=jpeg&qlt=95&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1476315575611" andURL:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#"];
    Product *iPad = [[Product alloc] initWithName:@"iPad" andImageURL:@"https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/i/pa/ipad/pro/ipad-pro-201603-gallery3_GEO_US?wid=2000&amp;hei=1536&amp;fmt=jpeg&amp;qlt=95&amp;op_sharpen=0&amp;resMode=bicub&amp;op_usm=0.5,0.5,0,0&amp;iccEmbed=0&amp;layer=comp&amp;.v=1473455607405" andURL:@"http://www.apple.com/shop/buy-ipad/ipad-pro"];
    Product *iPhone = [[Product alloc] initWithName:@"iPhone" andImageURL:@"https://store.storeimages.cdn-apple.com/4974/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone7/select/iphone7-select-2016?wid=222&hei=305&fmt=png-alpha&qlt=95&.v=1471892660314" andURL:@"http://www.apple.com/shop/buy-iphone/iphone-7"];
    Product *pixelC = [[Product alloc] initWithName:@"Pixel C" andImageURL:@"https://lh3.googleusercontent.com/45xc3JbXBkh_Bw81rwFLYLZlx9MPcfgicXPasuv9eS1Lhk17MpRTuT6DFFdkHdzjhg" andURL:@"https://store.google.com/product/pixel_c"];
    Product *daydreamView = [[Product alloc] initWithName:@"Daydream View" andImageURL:@"https://lh3.googleusercontent.com/FZm8MihgUmIlp-ru-g-KnvIIGt_BZxA6maadXuO-PF_Rx_2h3rMDROlXk6oIxuzXIqs" andURL:@"https://store.google.com/product/daydream_view"];
    Product *pixel = [[Product alloc] initWithName:@"Pixel" andImageURL:@"https://lh3.googleusercontent.com/PIVpB9f0-2sMc44exUz83yArl7EFuAH33_YkJrAbgT4S2upNYu_fMTj6txOv3WFOQEc" andURL:@"https://store.google.com/product/pixel_phone"];
    Product *holoLens = [[Product alloc] initWithName:@"HoloLens" andImageURL:@"https://compass-ssl.surface.com/assets/f5/2a/f52a1f76-0640-4a37-a650-51b0902f8427.jpg?n=Buy_Panel_1920.jpg" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800"];
    Product *lumia950 = [[Product alloc] initWithName:@"Lumia 950" andImageURL:@"https://compass-ssl.microsoft.com/assets/f2/2f/f22f364c-2bef-43ac-a420-1343b72cd437.jpg?n=hero-desktop.jpg" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600"];
    Product *surfacePro4 = [[Product alloc] initWithName:@"Surface Pro 4" andImageURL:@"https://dri1.img.digitalrivercontent.net/Storefront/Company/msintl/images/English/en-INTL-Surface-Pro4-Refresh-SU3-00001/en-INTL-XL-Surface-Pro4-Refresh-SU3-00001-RM1-mnco.jpg" andURL:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000"];
    Product *galaxyNote = [[Product alloc] initWithName:@"Galaxy Note" andImageURL:@"http://s7d2.scene7.com/is/image/SamsungUS/Pdpkeyfeature-sm-n920rzkeusc-600x600-C1-062016?$product-details-jpg$" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/"];
    Product *galaxyS = [[Product alloc] initWithName:@"Galaxy S" andImageURL:@"http://drop.ndtv.com/TECH/product_database/images/48201652044PM_635_samsung_galaxy_s.jpeg" andURL:@"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/"];
    Product *galaxyTab = [[Product alloc] initWithName:@"Galaxy Tab" andImageURL:@"http://thegioiipad.tk/wp-content/uploads/2016/06/12.png" andURL:@"http://www.samsung.com/us/mobile/tablets/"];
    
    self.companyList = [[NSMutableArray alloc] initWithObjects:apple, google, microsoft, samsung, nil];
    
    // Create arrays of products by company
    apple.products = [[NSMutableArray alloc] initWithObjects:appleWatch, iPad, iPhone, nil];
    google.products = [[NSMutableArray alloc] initWithObjects:pixelC, daydreamView, pixel, nil];
    microsoft.products = [[NSMutableArray alloc] initWithObjects:holoLens, lumia950, surfacePro4, nil];
    samsung.products = [[NSMutableArray alloc] initWithObjects:galaxyNote, galaxyS, galaxyTab, nil];
    
    self.managedCompanies = [[NSMutableArray alloc] init];
    // Create managedCompanyList based off of companyList
    for (Company *company in self.companyList) {
        
        ManagedCompany *managedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
        managedCompany.name = company.name;
        managedCompany.stockSymbol = company.stockSymbol;
        managedCompany.logoURL = company.logoURLString;
        managedCompany.price = company.price;
        
        [self.managedCompanies addObject:managedCompany];
        
        // Create managedProducts based off company.products
        for (Product *product in company.products) {
            ManagedProduct *managedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
            managedProduct.name = product.name;
            managedProduct.imageURL = product.imageURL;
            managedProduct.url = product.url;
            [managedCompany addProductsObject:managedProduct];
        }
    }
    [self.managedObjectContext save:nil];
}

- (void)addCompany:(NSString *)stockSymbol andImageURL:(NSString *)imageURL {
    Company *newCompany = [[Company alloc] initWithStockSymbol:stockSymbol andLogoURLString:imageURL];
    [self.companyList addObject:newCompany];
    [self getCompanyData];
    ManagedCompany *newManagedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    newManagedCompany.name = newCompany.name;
    newManagedCompany.stockSymbol = newCompany.stockSymbol;
    newManagedCompany.logoURL = newCompany.logoURLString;
    newManagedCompany.price = newCompany.price;
    [self.managedCompanies addObject:newManagedCompany];
}

- (void)addProduct:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url forCurrentCompany:(Company *)currentCompany {
    Product *newProduct = [[Product alloc] initWithName:name andImageURL:imageURL andURL:url];
    [currentCompany.products addObject:newProduct];
    
    ManagedProduct *newManagedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    newManagedProduct.name = newProduct.name;
    newManagedProduct.imageURL = newProduct.imageURL;
    newManagedProduct.url = newProduct.url;
    [[self.managedCompanies objectAtIndex:[self.companyList indexOfObject:currentCompany]] addProductsObject:newManagedProduct];
}

- (void)editCompany:(NSString *)stockSymbol andImageURL:(NSString *)imageURL forCurrentCompany:(Company *)currentCompany {
    for (ManagedCompany *mC in self.managedCompanies) {
        if (mC.stockSymbol == currentCompany.stockSymbol) {
            // set stockSymbol and logoURLString for NSObject (currentCompany)
            currentCompany.stockSymbol = stockSymbol;
            currentCompany.logoURLString = imageURL;
            // call getCompanyData to get name and price for currentComapny
            [self getCompanyData];
            // set name, stockSymbol, logoURLString and price to ManagedCompany (mC) from currentCompany
            mC.name = currentCompany.name;
            mC.stockSymbol = currentCompany.stockSymbol;
            mC.logoURL = currentCompany.logoURLString;
            mC.price = currentCompany.price;
        }
    }
}

- (void)editProduct:(NSString *)name andImageURL:(NSString *)imageURL andURL:(NSString *)url forCurrentCompany:(Company *)currentCompany forCurrentProduct:(Product *)currentProduct {
    ManagedCompany *currentManagedCompany = [self.managedCompanies objectAtIndex:[self.companyList indexOfObject:currentCompany]];
    for (ManagedProduct *mP in currentManagedCompany.products) {
        if(mP.name == currentProduct.name) {
            mP.name = name;
            mP.imageURL = imageURL;
            mP.url = url;
        }
    }
    currentProduct.name = name;
    currentProduct.imageURL = imageURL;
    currentProduct.url = url;
}

- (void)getCompanyData {
    NSString *urlString = [self getURLString];
    NSURL *url = [NSURL URLWithString:urlString];
    [self setCompanyNamesAndPricesWithURL:url];
}

- (NSString *)getURLString {
    NSString *urlString = [[NSString alloc] initWithString:@"http://finance.yahoo.com/d/quotes.csv?s="];
    for (int i=0; i<self.companyList.count; i++) {
        Company *currentCompany = self.companyList[i];
        if (currentCompany == [self.companyList lastObject]) {
            urlString = [urlString stringByAppendingString:currentCompany.stockSymbol];
            urlString = [urlString stringByAppendingString:@"&f=na"];
        }
        else {
            urlString = [urlString stringByAppendingString:currentCompany.stockSymbol];
            urlString = [urlString stringByAppendingString:@"+"];
        }
        
    }
    return urlString;
}

- (void)setCompanyNamesAndPricesWithURL:(NSURL *) url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    request.HTTPMethod = @"GET";
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error != nil){
            
        }
        else {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            dataString = [dataString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            NSArray *tempArray = [dataString componentsSeparatedByString:@"\n"];
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:tempArray];
            [mutableArray removeLastObject];
            NSMutableArray *dataArray = [[NSMutableArray alloc] init];
            
            for (NSString *element in mutableArray) {
                NSArray *sortingArray = [element componentsSeparatedByString:@","];
                NSString *stringToSort = @"";
                if([sortingArray count] > 2) {
                    for(int i=0; i<sortingArray.count - 1; i++) {
                        stringToSort = [stringToSort stringByAppendingString:sortingArray[i]];
                    }
                }
                else {
                    stringToSort = [sortingArray firstObject];
                }
                [dataArray addObject:stringToSort];
                [dataArray addObject:[sortingArray lastObject]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(){
                int index = 0;
                for(int i=0; i<dataArray.count; i += 2) {
                    Company *currentCompany = self.companyList[index];
                    currentCompany.name = dataArray[i];
                    if([dataArray[i+1] isEqualToString:@"N/A"]) {
                        currentCompany.price = dataArray[i+1];
                    }
                    else {
                        currentCompany.price = @"$";
                        currentCompany.price = [currentCompany.price stringByAppendingString:dataArray[i+1]];
                    }
                    index++;
                }
                [self.delegate receivedNamesAndPrices];
                
            });
        }
    }] resume];
}

#pragma mark - Core Data

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    self.managedObjectContext.undoManager = [[NSUndoManager alloc]init];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Model.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

- (void)saveCoreData {
    NSError *error = nil;
    if ([[self managedObjectContext] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

- (void)loadCoreData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ManagedCompany"];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error fetching objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    else {
        self.companyList = [[NSMutableArray alloc] init];
        self.managedCompanies = [[NSMutableArray alloc] initWithArray:results];
        for (ManagedCompany *mC in results) {
            self.products = [[NSMutableArray alloc] init];
            Company *company = [[Company alloc] init];
            company.name = mC.name;
            company.stockSymbol = mC.stockSymbol;
            company.logoURLString = mC.logoURL;
            company.price = mC.price;
            
            for (ManagedProduct *mP in mC.products) {
                Product *product = [[Product alloc] init];
                product.name = mP.name;
                product.imageURL = mP.imageURL;
                product.url = mP.url;
                [self.products addObject:product];
            }
            company.products = [[NSMutableArray alloc] initWithArray:self.products];
            [self.companyList addObject:company];
        }
    }
}

- (void)deletedCompanyAtIndex:(NSUInteger)indexPathRow {
    [self.managedObjectContext deleteObject:[self.managedCompanies objectAtIndex:indexPathRow]];
    [self.managedCompanies removeObjectAtIndex:indexPathRow];
    [self.companyList removeObjectAtIndex:indexPathRow];
}

- (void)deleteProductAtIndex:(NSUInteger)indexPathRow forCompany:(Company *)currentCompany {
    NSUInteger companyIndex = [self.companyList indexOfObject:currentCompany];
    ManagedCompany *currentMC = [self.managedCompanies objectAtIndex:companyIndex];
    ManagedProduct *productToDelete = [[currentMC.products allObjects] objectAtIndex:indexPathRow];    
    NSMutableSet *mutableSet = [currentMC.products mutableCopy];
    [mutableSet removeObject:productToDelete];
    currentMC.products = [mutableSet copy];
    [currentCompany.products removeObjectAtIndex:indexPathRow];
}



//- (void)dealloc {
//    // Should never be called, but just here for clarity really.
//    [self.someProperty release];
//    [super dealloc];
//}
    
    
@end
