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
        Company *newCompany = [[Company alloc] initWithStockSymbol:name andLogoURLString:imageURL];
        [self.companyList addObject:newCompany];
        [self getCompanyData];
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
        companyToEdit.logoURLString = imageURL;
        [self getCompanyData];
    }
    else {
        Product *productToEdit = [[[self.companyList objectAtIndex:[self.companyList indexOfObject:currentCompany]] products] objectAtIndex:[[[self.companyList objectAtIndex:[self.companyList indexOfObject:currentCompany]] products] indexOfObject:currentProduct]];
        productToEdit.name = name;
        productToEdit.image = imageURL;
        productToEdit.url = url;
    }
    
}



- (void)getCompanyData {
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
    NSURL *url = [NSURL URLWithString:urlString];
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
                [self.delegate receivedPrices];
                
            });
        }
    }] resume];
}

    

//- (void)dealloc {
//    // Should never be called, but just here for clarity really.
//    [self.someProperty release];
//    [super dealloc];
//}
    
    
@end
