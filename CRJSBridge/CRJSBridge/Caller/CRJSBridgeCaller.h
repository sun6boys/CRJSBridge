//
//  CRJSBridgeCaller.h
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CRWKWebViewMessageContext;
typedef void (^CRBridgeUnKnownMethodHandler)(CRWKWebViewMessageContext *context, NSString *methodName);

@interface CRJSBridgeCaller : NSObject

@property (nonatomic, copy) CRBridgeUnKnownMethodHandler unknowMethodHandler;

+ (instancetype)shareInstance;

- (void)callNativeMethod:(CRWKWebViewMessageContext *)context;
- (void)callJSMethod:(CRWKWebViewMessageContext *)context arguments:(id)arguments;
@end


@class WKWebView,UIViewController;
@interface CRWKWebViewMessageContext : NSObject

@property (nonatomic, weak, readonly) WKWebView *webView;
@property (nonatomic, weak, readonly) UIViewController *viewController;

@property (nonatomic, copy) NSDictionary *arguments;
@end
