//
//  DetailVC.h
//  NavCtrl
//
//  Created by Aditya Narayan on 2/16/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DetailVC : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSURL *url;

@end
