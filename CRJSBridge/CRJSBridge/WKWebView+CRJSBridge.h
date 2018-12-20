//
//  WKWebView+JYBridge.h
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import <WebKit/WebKit.h>
#import "CRJSBridgeCaller.h"

@interface WKWebView (CRJSBridge)

@property (nonatomic, strong, readonly) CRJSBridgeCaller *bridgeCaller;

- (void)configWebViewBridge;
@end

