//
//  Company.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/22/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

- (instancetype) initWithName: (NSString *)name {
    self = [super init];
    if (self) {
        self.companyName = name;
        self.companyLogo = [name stringByAppendingString:@"Logo.png"];
    }
    return self;
}

@end


//- (instancetype) initWithProductInfo: (NSString *)company {
//    if([company isEqualToString:@"apple"]) {
//        self.companyName = @"Apple mobile devices";
//        self.companyLogo = @"AppleLogo.png";
////        self.products = [[NSMutableArray alloc]initWithObjects:@"Apple Watch", @"iPad", @"iPhone", nil];
////        self.images = [[NSMutableArray alloc] initWithObjects:@"Apple Watch.png", @"iPad.png", @"iPhone.png", nil];
////        self.urls = [[NSMutableArray alloc] initWithObjects:@"http://www.apple.com/shop/buy-watch/apple-watch/silver-aluminum-pearl-woven-nylon?preSelect=false&product=MNPK2LL/A&step=detail#", @"http://www.apple.com/shop/buy-ipad/ipad-pro", @"http://www.apple.com/shop/buy-iphone/iphone-7", nil];
//    }
//    else if([company isEqualToString:@"google"]) {
//        self.companyName = @"Google mobile devices";
//        self.companyLogo = @"GoogleLogo.png";
////        self.products = [[NSMutableArray alloc] initWithObjects:@"Pixel C", @"Daydream View",@"Pixel", nil];
////        self.images = [[NSMutableArray alloc] initWithObjects:@"Pixel C.png", @"Daydream View.png", @"Pixel.png", nil];
////        self.urls = [[NSMutableArray alloc] initWithObjects:@"https://store.google.com/product/pixel_c", @"https://store.google.com/product/daydream_view", @"https://store.google.com/product/pixel_phone", nil];
//    }
//    else if([company isEqualToString:@"microsoft"]) {
//        self.companyName = @"Microsoft mobile devices";
//        self.companyLogo = @"MicrosoftLogo.png";
////        self.products = [[NSMutableArray alloc] initWithObjects:@"HoloLens", @"Lumia 950", @"Surface Pro 4", nil];
////        self.images = [[NSMutableArray alloc] initWithObjects:@"HoloLens.png", @"Lumia 950.png", @"Surface Pro 4.png", nil];
////        self.urls = [[NSMutableArray alloc] initWithObjects:@"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-HoloLens-Development-Edition/productID.5061263800", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Lumia-950--Unlocked/productID.326602600", @"https://www.microsoftstore.com/store/msusa/en_US/pdp/Microsoft-Surface-Pro-4/productID.5072641000", nil];
//    }
//    else {
//        self.companyName = @"Samsung mobile devices";
//        self.companyLogo = @"SamsungLogo.png";
////        self.products = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note", @"Galaxy S", @"Galaxy Tab", nil];;
////        self.images = [[NSMutableArray alloc] initWithObjects:@"Galaxy Note.png", @"Galaxy S4.png", @"Galaxy Tab.png", nil];
////        self.urls = [[NSMutableArray alloc] initWithObjects:@"http://www.samsung.com/us/mobile/phones/galaxy-note/s/_/n-10+11+hv1rp+zq1xb/", @"http://www.samsung.com/us/mobile/phones/all-phones/s/galaxy_s/_/n-10+11+hv1rp+zq1xa/", @"http://www.samsung.com/us/mobile/tablets/", nil];
//    }
//
//    self.product = [[Product alloc] initWithProductInfo:self.companyName];
//
//    return self;
//}
