//
//  CRJSBridgeCaller+Camera.m
//  JYWKWebViewBridge
//
//  Created by Charon on 2018/12/12.
//  Copyright © 2018 Charon. All rights reserved.
//

#import "CRJSBridgeCaller+Camera.h"
#import <UIKit/UIKit.h>

@implementation CRJSBridgeCaller (Camera)

- (void)showPhotoAlbum:(CRWKWebViewMessageContext *)context
{
    UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [context.viewController presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)noParamsTest
{
    
}
@end
