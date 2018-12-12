//
//  CRJSBridgeCaller+CallBackTest.m
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller+CallBackTest.h"

@implementation CRJSBridgeCaller (CallBackTest)

- (void)testCallBack:(CRWKWebViewMessageContext *)context
{
    [self callJSMethod:context arguments:@"你好，这是测试"];
}

@end
