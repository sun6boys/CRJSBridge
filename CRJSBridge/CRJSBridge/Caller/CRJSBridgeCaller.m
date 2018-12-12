//
//  CRJSBridgeCaller.m
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller.h"
#import "CRWKWebViewMessageContext+Private.h"

@implementation CRJSBridgeCaller

+ (instancetype)shareInstance
{
    static CRJSBridgeCaller *caller = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        caller = [[self alloc] init];
    });
    return caller;
}

#pragma mark - public methods
- (void)callNativeMethod:(CRWKWebViewMessageContext *)context
{
    NSString *hasPramsMethodString = [NSString stringWithFormat:@"%@:",context.methodName];
    
    SEL noParamsAction = NSSelectorFromString(context.methodName);
    SEL hasParamsAction = NSSelectorFromString(hasPramsMethodString);
    
    if([self respondsToSelector:noParamsAction]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:noParamsAction];
    }else if ([self respondsToSelector:hasParamsAction]){
        [self performSelector:hasParamsAction withObject:context];
#pragma clang diagnostic pop
    }else{
        self.unknowMethodHandler ? self.unknowMethodHandler(context, context.methodName) : nil;
        NSLog(@"can't find %@ method",context.methodName);
    }
}

- (void)callJSMethod:(CRWKWebViewMessageContext *)context arguments:(id)arguments
{
    BOOL paramsNoValidate = [arguments isKindOfClass:[NSString class]] == NO &&
                            [arguments isKindOfClass:[NSNumber class]] == NO &&
                            [arguments isKindOfClass:[NSDictionary class]] == NO &&
                            [arguments isKindOfClass:[NSArray class]] == NO;
    if(paramsNoValidate){
        NSAssert(paramsNoValidate == NO, @"arguments should be NSArray or NSString or NSNumber or NSDictonary");
        return;
    }
    NSString *jsonStringParams = [context jsStringParamsWithCallBackArguments:arguments];
    NSString *script = [NSString stringWithFormat:@"CRJSBridge.callBack(%@);",jsonStringParams];
    [context.webView evaluateJavaScript:script completionHandler:nil];
}

@end


@interface UIView(_JYRelatedViewController)

- (UIViewController *)jy_relatedViewController;

@end

static NSString * const kCRMessageKeyMethodName = @"methodName";
static NSString * const kCRMessageKeyCallBackId = @"identifier";
static NSString * const kCRMessageKeyCallBackContent = @"content";

static NSString *_JYBridgeStringFromObject(id object){
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

@implementation CRWKWebViewMessageContext

#pragma mark - life cycles
- (instancetype)initWithMessage:(WKScriptMessage *)message
{
    self = [super init];
    if (self) {
        _webView = message.webView;
        _methodName = message.body[kCRMessageKeyMethodName];
        _callBakId = message.body[kCRMessageKeyCallBackId];
        _arguments = message.body[kCRMessageKeyCallBackContent];
    }
    return self;
}

#pragma mark - piblic methods
- (NSString *)jsStringParamsWithCallBackArguments:(id)arguments
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[kCRMessageKeyCallBackId] = self.callBakId;
    params[kCRMessageKeyCallBackContent] = arguments;
    
    NSString *jsonString = _JYBridgeStringFromObject(params);
    return jsonString;
}

#pragma mark - getters
- (UIViewController *)viewController
{
    return [self.webView jy_relatedViewController];
}
@end


@implementation UIView (_JYRelatedViewController)

- (UIViewController *)jy_relatedViewController
{
    UIViewController *relatedViewController = (UIViewController *)[self jy_traverseResponderChainForUIViewController];
    return relatedViewController;
}

- (id)jy_traverseResponderChainForUIViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder jy_traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end
