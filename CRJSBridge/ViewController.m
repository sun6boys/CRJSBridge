//
//  ViewController.m
//  CRJSBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018年 Charon. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "WKWebView+CRJSBridge.h"

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webview;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webview];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self.webview loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - getters
- (WKWebView *)webview
{
    if (_webview == nil) {
        WKWebViewConfiguration *webviewConfiguration = [[WKWebViewConfiguration alloc] init];
        webviewConfiguration.userContentController = [[WKUserContentController alloc] init];
        
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:webviewConfiguration];
        _webview.navigationDelegate = self;
        _webview.UIDelegate = self;
        
        //初始化hybrid
        [_webview configWebViewBridge];
    }
    return _webview;
}
@end

