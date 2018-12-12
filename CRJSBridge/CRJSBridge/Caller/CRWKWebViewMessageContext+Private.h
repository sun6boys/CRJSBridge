//
//  CRWKWebViewMessageContext+Private.h
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller.h"
#import <WebKit/WebKit.h>

@interface CRWKWebViewMessageContext ()

@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, copy) NSString *callBakId;

- (instancetype)initWithMessage:(WKScriptMessage *)message;
- (NSString *)jsStringParamsWithCallBackArguments:(id)arguments;
@end

