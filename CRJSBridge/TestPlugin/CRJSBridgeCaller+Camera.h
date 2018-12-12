//
//  CRJSBridgeCaller+Camera.h
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller.h"

NS_ASSUME_NONNULL_BEGIN

@interface CRJSBridgeCaller (Camera)

- (void)showPhotoAlbum:(CRWKWebViewMessageContext *)context;

- (void)noParamsTest;
@end

NS_ASSUME_NONNULL_END
