//
//  DetailVC.m
//  NavCtrl
//
//  Created by Aditya Narayan on 2/16/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "DetailVC.h"

@interface DetailVC ()

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds] configuration:configuration];
    webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    [self.view addSubview:webView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
