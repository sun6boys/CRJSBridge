//
//  WKWebView+JYBridge.m
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "WKWebView+CRJSBridge.h"
#import "CRWKWebViewMessageContext+Private.h"

@interface _CRWKWebViewBridgeMessageHandler : NSObject<WKScriptMessageHandler>

@end

@implementation _CRWKWebViewBridgeMessageHandler

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    CRWKWebViewMessageContext *messageContext = [[CRWKWebViewMessageContext alloc] initWithMessage:message];
    [[CRJSBridgeCaller shareInstance] callNativeMethod:messageContext];
}

@end


@implementation WKWebView (CRJSBridge)

- (void)configWebViewBridge
{
    NSAssert(self.configuration != nil, @"configuration can't be nil");
    
    if(self.configuration.userContentController == nil){
        self.configuration.userContentController = [[WKUserContentController alloc] init];
    }
    NSString *bridgeJSString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CRJSBridge" ofType:@"js"] encoding:NSUTF8StringEncoding error:NULL];
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeJSString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    
    [self.configuration.userContentController addUserScript:userScript];
    [self.configuration.userContentController addScriptMessageHandler:[[_CRWKWebViewBridgeMessageHandler alloc] init] name:@"NativeMethodMessage"];
}

@end



