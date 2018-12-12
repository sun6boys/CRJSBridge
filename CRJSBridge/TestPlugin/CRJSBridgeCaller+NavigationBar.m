//
//  CRJSBridgeCaller+NavigationBar.m
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller+NavigationBar.h"
#import <UIKit/UIKit.h>

@implementation CRJSBridgeCaller (NavigationBar)

- (void)setTitle:(CRWKWebViewMessageContext *)context
{
    context.viewController.navigationItem.title = context.arguments[@"title"];
}
@end
